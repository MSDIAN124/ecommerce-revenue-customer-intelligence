
from pathlib import Path
import pandas as pd

PROJECT_ROOT = Path(__file__).resolve().parent.parent
RAW_DIR = PROJECT_ROOT / "data" / "raw"
OUTPUT_DIR = PROJECT_ROOT / "outputs"

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

if not RAW_DIR.exists():
    raise FileNotFoundError(f"Raw data folder not found: {RAW_DIR}")

csv_files = sorted(RAW_DIR.glob("*.csv"))

if not csv_files:
    raise FileNotFoundError(f"No CSV files found in {RAW_DIR}")

dictionary_rows = []

for csv_file in csv_files:
    print(f"Inspecting: {csv_file.name}")

    df = pd.read_csv(csv_file, low_memory=False)
    row_count = len(df)

    for column in df.columns:
        non_null_values = df[column].dropna()
        example = (
            str(non_null_values.iloc[0])
            if not non_null_values.empty
            else ""
        )

        dictionary_rows.append({
            "dataset": csv_file.name,
            "row_count": row_count,
            "column_name": column,
            "pandas_dtype": str(df[column].dtype),
            "non_null_count": int(df[column].notna().sum()),
            "missing_count": int(df[column].isna().sum()),
            "missing_pct": round(
                df[column].isna().mean() * 100, 2
            ),
            "example_value": example,
            "business_description": ""
        })

    del df

dictionary = pd.DataFrame(dictionary_rows)

output_file = OUTPUT_DIR / "data_dictionary.csv"
dictionary.to_csv(output_file, index=False)

print("\nData dictionary created successfully!")
print(f"Datasets inspected: {len(csv_files)}")
print(f"Columns documented: {len(dictionary)}")
print(f"Saved to: {output_file}")
