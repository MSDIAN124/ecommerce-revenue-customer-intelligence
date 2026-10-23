
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
RAW = ROOT / "data" / "raw"

def load(name):
    return pd.read_csv(RAW / name, low_memory=False)

orders = load("olist_orders_dataset.csv")
customers = load("olist_customers_dataset.csv")
items = load("olist_order_items_dataset.csv")
payments = load("olist_order_payments_dataset.csv")
reviews = load("olist_order_reviews_dataset.csv")
products = load("olist_products_dataset.csv")
sellers = load("olist_sellers_dataset.csv")
geo = load("olist_geolocation_dataset.csv")
translation = load("product_category_name_translation.csv")

def check_fk(label, child_values, parent_values):
    child = set(child_values.dropna().unique())
    parent = set(parent_values.dropna().unique())
    unmatched = child - parent
    print(f"\n{label}")
    print(f"Distinct child IDs: {len(child):,}")
    print(f"Unmatched child IDs: {len(unmatched):,}")

check_fk("Orders -> Customers",
         orders["customer_id"], customers["customer_id"])

check_fk("Items -> Orders",
         items["order_id"], orders["order_id"])

check_fk("Items -> Products",
         items["product_id"], products["product_id"])

check_fk("Items -> Sellers",
         items["seller_id"], sellers["seller_id"])

check_fk("Payments -> Orders",
         payments["order_id"], orders["order_id"])

check_fk("Reviews -> Orders",
         reviews["order_id"], orders["order_id"])

check_fk("Products -> Category translation",
         products["product_category_name"],
         translation["product_category_name"])

print("\nCUSTOMER KEY CHECK")
print("Customer rows:", len(customers))
print("Unique customer IDs:", customers["customer_id"].nunique())
print("Unique customer unique IDs:",
      customers["customer_unique_id"].nunique())

print("\nREVIEW ORDER CHECK")
print("Review rows:", len(reviews))
print("Unique order IDs in reviews:", reviews["order_id"].nunique())
print("Orders with multiple review rows:",
      (reviews.groupby("order_id").size() > 1).sum())

print("\nGEOLOCATION CHECK")
print("Geolocation rows:", len(geo))
print("Unique ZIP prefixes:", geo["geolocation_zip_code_prefix"].nunique())
