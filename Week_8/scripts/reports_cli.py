import sqlite3
from datetime import datetime, timedelta
import os

# =====================================
# Database Path
# =====================================

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DB_PATH = os.path.join(BASE_DIR, "..", "database", "ecommerce.db")


# =====================================
# Get Summary
# =====================================

def get_summary(start_date, end_date):
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Total Orders
    cursor.execute("""
        SELECT COUNT(*)
        FROM orders
        WHERE DATE(order_date) BETWEEN ? AND ?
    """, (start_date, end_date))

    total_orders = cursor.fetchone()[0]

    # Revenue
    cursor.execute("""
        SELECT ROUND(
            SUM(
                oi.quantity *
                oi.unit_price *
                (1 - oi.discount_percent / 100.0)
            ),
        2)

        FROM order_items oi
        JOIN orders o
            ON oi.order_id = o.order_id

        WHERE DATE(o.order_date) BETWEEN ? AND ?
          AND oi.quantity > 0
    """, (start_date, end_date))

    revenue = cursor.fetchone()[0] or 0

    # Unique Customers
    cursor.execute("""
        SELECT COUNT(DISTINCT customer_id)
        FROM orders
        WHERE DATE(order_date) BETWEEN ? AND ?
    """, (start_date, end_date))

    customers = cursor.fetchone()[0]

    # Top Products
    cursor.execute("""
        SELECT
            p.product_name,
            SUM(oi.quantity) AS total_qty

        FROM order_items oi
        JOIN products p
            ON oi.product_id = p.product_id
        JOIN orders o
            ON oi.order_id = o.order_id

        WHERE DATE(o.order_date) BETWEEN ? AND ?

        GROUP BY p.product_name

        ORDER BY total_qty DESC

        LIMIT 3
    """, (start_date, end_date))

    top_products = cursor.fetchall()

    conn.close()

    return total_orders, revenue, customers, top_products


# =====================================
# Previous Period
# =====================================

def previous_period(start_date, end_date):
    start = datetime.strptime(start_date, "%Y-%m-%d")
    end = datetime.strptime(end_date, "%Y-%m-%d")

    diff = end - start

    prev_end = start - timedelta(days=1)
    prev_start = prev_end - diff

    return (
        prev_start.strftime("%Y-%m-%d"),
        prev_end.strftime("%Y-%m-%d")
    )


# =====================================
# Main
# =====================================

print("=" * 50)
print("        E-Commerce Analytics CLI")
print("=" * 50)

print("1. Daily Report")
print("2. Weekly Report")
print("3. Monthly Report")

choice = input("\nChoose Report Type (1/2/3): ")

if choice not in ["1", "2", "3"]:
    print("Invalid choice!")
    exit()

start_date = input("Start Date (YYYY-MM-DD): ")
end_date = input("End Date (YYYY-MM-DD): ")

# Validate dates
try:
    s = datetime.strptime(start_date, "%Y-%m-%d")
    e = datetime.strptime(end_date, "%Y-%m-%d")

    if s > e:
        print("Start date cannot be after End date.")
        exit()

except ValueError:
    print("Invalid date format. Use YYYY-MM-DD.")
    exit()

orders, revenue, customers, products = get_summary(start_date, end_date)

prev_start, prev_end = previous_period(start_date, end_date)

prev_orders, prev_revenue, _, _ = get_summary(prev_start, prev_end)

if prev_revenue == 0:
    change = 0
else:
    change = ((revenue - prev_revenue) / prev_revenue) * 100

print("\n" + "=" * 50)
print("REPORT SUMMARY")
print("=" * 50)

print(f"Total Orders       : {orders}")
print(f"Revenue            : ₹{revenue:,.2f}")
print(f"Unique Customers   : {customers}")

print("\nTop 3 Products")
print("-" * 30)

if products:
    for name, qty in products:
        print(f"{name:<25} {qty} units")
else:
    print("No sales found.")

print("-" * 30)
print(f"Revenue Change     : {change:.2f}%")

print("=" * 50)