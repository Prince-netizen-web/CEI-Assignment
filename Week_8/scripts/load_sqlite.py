import sqlite3
import pandas as pd
import os

# =====================================
# Paths
# =====================================

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

DB_PATH = os.path.join(BASE_DIR, "..", "database", "ecommerce.db")
DATA_PATH = os.path.join(BASE_DIR, "..", "data", "cleaned")

os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)

# =====================================
# Check CSV files
# =====================================

files = [
    "customers_clean.csv",
    "products_clean.csv",
    "orders_clean.csv",
    "order_items_clean.csv"
]

for file in files:
    path = os.path.join(DATA_PATH, file)
    if not os.path.exists(path):
        raise FileNotFoundError(f"{file} not found at\n{path}")

# =====================================
# Read CSVs
# =====================================

customers = pd.read_csv(os.path.join(DATA_PATH, "customers_clean.csv"))
products = pd.read_csv(os.path.join(DATA_PATH, "products_clean.csv"))
orders = pd.read_csv(os.path.join(DATA_PATH, "orders_clean.csv"))
order_items = pd.read_csv(os.path.join(DATA_PATH, "order_items_clean.csv"))

# =====================================
# Connect Database
# =====================================

conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

cursor.execute("PRAGMA foreign_keys = ON;")

print("Connected to SQLite Database")

# =====================================
# Create Tables
# =====================================

cursor.execute("""
CREATE TABLE IF NOT EXISTS customers(
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT NOT NULL,
    email TEXT,
    registration_date TEXT,
    customer_type TEXT
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS products(
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT,
    subcategory TEXT,
    cost_price REAL
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS orders(
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date TEXT,
    status TEXT,
    region_code TEXT,
    FOREIGN KEY(customer_id)
        REFERENCES customers(customer_id)
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS order_items(
    item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    unit_price REAL,
    discount_percent REAL,
    FOREIGN KEY(order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY(product_id)
        REFERENCES products(product_id)
)
""")

conn.commit()

# =====================================
# Clear Existing Data
# =====================================

cursor.execute("DELETE FROM order_items")
cursor.execute("DELETE FROM orders")
cursor.execute("DELETE FROM products")
cursor.execute("DELETE FROM customers")

conn.commit()

# =====================================
# Insert Data
# =====================================

customers.to_sql(
    "customers",
    conn,
    if_exists="append",
    index=False
)

products.to_sql(
    "products",
    conn,
    if_exists="append",
    index=False
)

orders.to_sql(
    "orders",
    conn,
    if_exists="append",
    index=False
)

order_items.to_sql(
    "order_items",
    conn,
    if_exists="append",
    index=False
)

conn.commit()

print("\nData inserted successfully.\n")

# =====================================
# Verify Records
# =====================================

tables = [
    "customers",
    "products",
    "orders",
    "order_items"
]

for table in tables:
    cursor.execute(f"SELECT COUNT(*) FROM {table}")
    count = cursor.fetchone()[0]
    print(f"{table:<15}: {count} records")

# =====================================
# Preview Tables
# =====================================

for table in tables:
    print("\n" + "=" * 50)
    print(table.upper())
    print("=" * 50)

    df = pd.read_sql_query(
        f"SELECT * FROM {table} LIMIT 5",
        conn
    )

    print(df)

conn.close()

print("\nDatabase Loaded Successfully.")