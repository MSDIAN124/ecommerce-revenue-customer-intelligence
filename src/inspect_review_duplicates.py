
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
path = ROOT / "data" / "raw" / "olist_order_reviews_dataset.csv"

df = pd.read_csv(path)

duplicated = df[df.duplicated("review_id", keep=False)].sort_values(
    ["review_id", "order_id"]
)

print("Rows involved in repeated review IDs:", len(duplicated))
print("Repeated review IDs:", duplicated["review_id"].nunique())
print("Repeated IDs linked to multiple orders:",
      (duplicated.groupby("review_id")["order_id"].nunique() > 1).sum())

print("\nFirst 20 rows with repeated review IDs:")
columns = [
    "review_id",
    "order_id",
    "review_score",
    "review_creation_date",
    "review_answer_timestamp",
]
print(duplicated[columns].head(20).to_string(index=False))

print("\nExact duplicate rows across all columns:",
      df.duplicated().sum())

print("\nReview score distribution:")
print(df["review_score"].value_counts(dropna=False).sort_index())
