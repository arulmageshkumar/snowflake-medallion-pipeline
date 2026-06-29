import random
import uuid
from datetime import datetime
from faker import Faker
import pandas as pd
import os

fake = Faker("en_IN")

# ==========================
# Configuration
# ==========================
NUM_ROWS = 100000
OUTPUT_FILE = "../data/raw/raw_sales.csv"

# ==========================
# Master Data
# ==========================

cities = [
    "Chennai",
    "chennai",
    "CHENNAI",
    " Bangalore",
    "Hyderabad",
    "Mumbai",
    "Pune",
    None
]

categories = {
    "Electronics": (5000, 75000),
    "Clothing": (300, 5000),
    "Furniture": (3000, 50000),
    "Books": (100, 1500),
    "Groceries": (50, 1500)
}

payment_methods = [
    "UPI",
    "Credit Card",
    "Debit Card",
    "Net Banking",
    "Cash on Delivery"
]

order_statuses = [
    "Delivered",
    "Pending",
    "Cancelled",
    "Returned",
    "UNKNOWN"
]

rows = []

# Used later to create duplicates
duplicate_orders = []

# ==========================
# Generate Data
# ==========================

for i in range(NUM_ROWS):

    order_id = f"ORD{100000 + i}"

    customer_id = f"CUST{random.randint(1000,9999)}"

    order_date = fake.date_between(
        start_date="-2y",
        end_date="today"
    )

    city = random.choices(
        cities,
        weights=[30,5,5,10,15,15,15,5],
        k=1
    )[0]

    category = random.choice(list(categories.keys()))

    min_price, max_price = categories[category]

    unit_price = round(random.uniform(min_price, max_price),2)

    quantity = random.randint(1,5)

    discount = round(random.uniform(0,0.30),2)

    # Introduce a few bad discount values
    if random.random() < 0.005:
        discount = random.choice([-0.10,1.25])

    payment = random.choices(
        payment_methods,
        weights=[45,20,15,10,10],
        k=1
    )[0]

    status = random.choices(
        order_statuses,
        weights=[75,10,5,5,5],
        k=1
    )[0]

    rows.append([
        order_id,
        order_date,
        customer_id,
        city,
        category,
        quantity,
        unit_price,
        discount,
        payment,
        status
    ])

    # Save a few rows for duplicate generation
    if random.random() < 0.001:
        duplicate_orders.append(rows[-1])

# Add duplicate records intentionally
rows.extend(duplicate_orders)

# ==========================
# Create DataFrame
# ==========================

columns = [
    "order_id",
    "order_date",
    "customer_id",
    "customer_city",
    "product_category",
    "quantity",
    "unit_price",
    "discount_pct",
    "payment_method",
    "order_status"
]

df = pd.DataFrame(rows, columns=columns)

# ==========================
# Create folder if needed
# ==========================

os.makedirs(os.path.dirname(OUTPUT_FILE), exist_ok=True)

# ==========================
# Save CSV
# ==========================

df.to_csv(OUTPUT_FILE, index=False)

print("=" * 50)
print(f"Rows Generated : {len(df):,}")
print(f"CSV Location   : {OUTPUT_FILE}")
print("=" * 50)