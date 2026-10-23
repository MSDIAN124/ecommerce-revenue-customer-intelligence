
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
RAW = ROOT / "data" / "raw"

# Check all expected files
expected = [
    "olist_customers_dataset.csv",
    "olist_geolocation_dataset.csv",
    "olist_order_items_dataset.csv",
    "olist_order_payments_dataset.csv",
    "olist_order_reviews_dataset.csv",
    "olist_orders_dataset.csv",
    "olist_products_dataset.csv",
    "olist_sellers_dataset.csv",
    "product_category_name_translation.csv",
]

print("FILE CHECK")
for name in expected:
    print(f"{name}: {'FOUND' if (RAW / name).exists() else 'MISSING'}")

# Column-level missing values
print("\nMISSING VALUES BY COLUMN")
for name in expected:
    path = RAW / name
    if not path.exists():
        continue

    df = pd.read_csv(path, low_memory=False)
    missing = df.isna().sum()
    missing = missing[missing > 0]

    print(f"\n{name} ({len(df):,} rows)")
    if missing.empty:
        print("No missing values")
    else:
        for column, count in missing.items():
            print(f"  {column}: {count:,} ({count / len(df):.1%})")

# Order status distribution
orders_path = RAW / "olist_orders_dataset.csv"
if orders_path.exists():
    orders = pd.read_csv(orders_path)
    print("\nORDER STATUS COUNTS")
    print(orders["order_status"].value_counts(dropna=False).to_string())

    print("\nORDER DATE RANGE")
    dates = pd.to_datetime(
        orders["order_purchase_timestamp"], errors="coerce"
    )
    print(f"Earliest purchase: {dates.min()}")
    print(f"Latest purchase:   {dates.max()}")

    print("\nORDER KEY CHECK")
    print(f"Rows: {len(orders):,}")
    print(f"Unique order IDs: {orders['order_id'].nunique():,}")
    print(f"Duplicate order IDs: {orders['order_id'].duplicated().sum():,}")

# Item-level key checks
items_path = RAW / "olist_order_items_dataset.csv"
if items_path.exists():
    items = pd.read_csv(items_path)
    print("\nORDER ITEM KEY CHECK")
    print(f"Rows: {len(items):,}")
    print(
        "Duplicate order_id + order_item_id pairs:",
        items.duplicated(["order_id", "order_item_id"]).sum()
    )

# Payment and review key checks
for name, key in [
    ("olist_order_payments_dataset.csv", ["order_id", "payment_sequential"]),
    ("olist_order_reviews_dataset.csv", ["review_id"]),
]:
    path = RAW / name
    if path.exists():
        df = pd.read_csv(path)
        print(f"\nKEY CHECK: {name}")
        print(f"Rows: {len(df):,}")
        print(f"Unique {key}: {len(df.drop_duplicates(key)):,}")
        print(f"Duplicate key combinations: {df.duplicated(key).sum():,}")
