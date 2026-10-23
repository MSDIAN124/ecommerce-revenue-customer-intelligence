
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
RAW = ROOT / "data" / "raw"

def load(name):
    return pd.read_csv(RAW / name, low_memory=False)

products = load("olist_products_dataset.csv")
translation = load("product_category_name_translation.csv")
geo = load("olist_geolocation_dataset.csv")

# 1. Categories without an English translation
product_categories = set(products["product_category_name"].dropna().unique())
translated_categories = set(
    translation["product_category_name"].dropna().unique()
)

untranslated = sorted(product_categories - translated_categories)

print("UNTRANSLATED PRODUCT CATEGORIES")
print("Count:", len(untranslated))
for category in untranslated:
    print(repr(category))

print("\nProducts with missing category:",
      products["product_category_name"].isna().sum())

# 2. Geolocation duplication checks
zip_col = "geolocation_zip_code_prefix"
lat_col = "geolocation_lat"
lng_col = "geolocation_lng"

print("\nGEOLOCATION DUPLICATION CHECK")
print("Total rows:", len(geo))
print("Exact duplicate rows:", geo.duplicated().sum())
print("Repeated ZIP-prefix rows:", geo[zip_col].duplicated().sum())
print("Unique ZIP prefixes:", geo[zip_col].nunique())

# Measure coordinate variation within ZIP prefixes
variation = geo.groupby(zip_col).agg(
    latitude_values=(lat_col, "nunique"),
    longitude_values=(lng_col, "nunique"),
    rows=(zip_col, "size"),
)

multi_coordinate = variation[
    (variation["latitude_values"] > 1)
    | (variation["longitude_values"] > 1)
]

print("ZIP prefixes with multiple coordinate values:",
      len(multi_coordinate))
print("\nExample ZIP prefixes with multiple coordinates:")
print(multi_coordinate.head(10).to_string())

# 3. Check whether customer_unique_id can support repeat analysis
customers = load("olist_customers_dataset.csv")
unique_customer_counts = customers.groupby(
    "customer_unique_id"
)["customer_id"].nunique()

print("\nCUSTOMER ID RELATIONSHIP")
print("Customer rows:", len(customers))
print("Distinct customer_unique_id:",
      customers["customer_unique_id"].nunique())
print("Unique customers represented by multiple customer_id values:",
      (unique_customer_counts > 1).sum())
