
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
RAW = ROOT / "data" / "raw"
OUT = ROOT / "outputs"
OUT.mkdir(exist_ok=True)

files = sorted(RAW.glob("*.csv"))
summary = []
missing_rows = []

for path in files:
    df = pd.read_csv(path, low_memory=False)

    summary.append({
        "file": path.name,
        "row_count": len(df),
        "column_count": len(df.columns),
        "exact_duplicate_rows": int(df.duplicated().sum()),
        "total_missing_cells": int(df.isna().sum().sum()),
    })

    for column, count in df.isna().sum().items():
        if count:
            missing_rows.append({
                "file": path.name,
                "column": column,
                "missing_count": int(count),
                "missing_pct": round(count / len(df) * 100, 2),
            })

pd.DataFrame(summary).to_csv(
    OUT / "dataset_inventory.csv", index=False
)
pd.DataFrame(missing_rows).to_csv(
    OUT / "missing_values_report.csv", index=False
)

print("Created:")
print(OUT / "dataset_inventory.csv")
print(OUT / "missing_values_report.csv")
print("\nDataset inventory:")
print(pd.DataFrame(summary).to_string(index=False))
