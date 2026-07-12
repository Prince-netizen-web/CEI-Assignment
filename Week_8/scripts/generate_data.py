import pandas as pd
import random
import os
from faker import Faker
from datetime import datetime, timedelta

fake = Faker()

random.seed(42)
Faker.seed(42)


NUM_CUSTOMERS = 500
NUM_PRODUCTS = 500
NUM_ORDERS = 700
NUM_ORDER_ITEMS = 1200

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
OUTPUT_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, "..", "data", "raw"))

os.makedirs(OUTPUT_DIR, exist_ok=True)


# Customer Table


def generate_customers():

    customer_types = ["REGULAR", "PREMIUM", "VIP"]

    customers = []

    for i in range(1, NUM_CUSTOMERS + 1):

        email = fake.email()

        # 2% invalid emails
        if random.random() < 0.02:
            email = email.replace("@", "")

        customers.append({

            "customer_id": i,
            "customer_name": fake.name(),
            "email": email,
            "registration_date": fake.date_between(
                start_date="-5y",
                end_date="today"
            ),
            "customer_type": random.choice(customer_types)

        })

    df = pd.DataFrame(customers)

    df.to_csv(
        os.path.join(OUTPUT_DIR, "customers.csv"),
        index=False
    )

    return df



# Product Table 

def generate_products():

    categories = {

        "Electronics": [
            "Mobile",
            "Laptop",
            "Camera",
            "Headphones"
        ],

        "Clothing": [
            "Men",
            "Women",
            "Kids"
        ],

        "Home": [
            "Furniture",
            "Kitchen",
            "Decor"
        ],

        "Books": [
            "Novel",
            "Education",
            "Biography"
        ]

    }

    products = []

    for i in range(1, NUM_PRODUCTS + 1):

        category = random.choice(list(categories.keys()))

        subcategory = random.choice(categories[category])

        name = subcategory

        # Introduce messy names
        if random.random() < 0.05:
            name = "   " + name.upper() + "   "

        products.append({

            "product_id": i,
            "product_name": name,
            "category": category,
            "subcategory": subcategory,
            "cost_price": round(random.uniform(50, 5000), 2)

        })

    df = pd.DataFrame(products)

    df.to_csv(
        os.path.join(OUTPUT_DIR, "products.csv"),
        index=False
    )

    return df


# Order  Table

def generate_orders():

    statuses = [

        "PLACED",
        "SHIPPED",
        "DELIVERED",
        "CANCELLED",
        "RETURNED"

    ]

    regions = [

        "NORTH",
        "SOUTH",
        "EAST",
        "WEST"

    ]

    orders = []

    for i in range(1, NUM_ORDERS + 1):

        customer = random.randint(1, NUM_CUSTOMERS)

        # 5% NULL customer_id
        if random.random() < 0.05:
            customer = None

        order_date = fake.date_time_between(
            start_date="-2y",
            end_date="now"
        )

        # Wrong date format
        if random.random() < 0.05:
            order_date = order_date.strftime("%d-%m-%Y")
        else:
            order_date = order_date.strftime("%Y-%m-%d %H:%M:%S")

        orders.append({

            "order_id": i,
            "customer_id": customer,
            "order_date": order_date,
            "status": random.choice(statuses),
            "region_code": random.choice(regions)

        })

    df = pd.DataFrame(orders)

    df.to_csv(
        os.path.join(OUTPUT_DIR, "orders.csv"),
        index=False
    )

    return df



# Order Item Table 

def generate_order_items():

    items = []

    for i in range(1, NUM_ORDER_ITEMS + 1):

        quantity = random.randint(1, 10)

        # 3% negative quantity
        if random.random() < 0.03:
            quantity *= -1

        items.append({

            "item_id": i,

            "order_id": random.randint(
                1,
                NUM_ORDERS
            ),

            "product_id": random.randint(
                1,
                NUM_PRODUCTS
            ),

            "quantity": quantity,

            "unit_price": round(
                random.uniform(100, 6000),
                2
            ),

            "discount_percent": random.randint(0, 50)

        })

    df = pd.DataFrame(items)

    df.to_csv(
        os.path.join(OUTPUT_DIR, "order_items.csv"),
        index=False
    )

    return df


# Main function 


def main():

    print("Generating Customers...")
    generate_customers()

    print("Generating Products...")
    generate_products()

    print("Generating Orders...")
    generate_orders()

    print("Generating Order Items...")
    generate_order_items()

    print("\nData Generation Completed Successfully!")

    print(f"\nCSV files saved in: {OUTPUT_DIR}")


if __name__ == "__main__":
    main()