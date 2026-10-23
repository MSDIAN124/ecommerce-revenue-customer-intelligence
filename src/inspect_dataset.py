
from pathlib import Path
import pandas as pd

# Project root = parent of the src folder
PROJECT_ROOT = Path(__file__).resolve().parent.parent
RAW_DIR = PROJECT_ROOT / "data" / "raw"

csv_files = sorted(RAW_DIR.glob("*.csv"))

if not csv_files:
    raise FileNotFoundError(
        f"No CSV files found in: {RAW_DIR}\n"
        "Check that the nine CSV files are inside data/raw/."
    )

print(f"CSV files found: {len(csv_files)}")
print("=" * 80)

for file_path in csv_files:
    print(f"\nFILE: {file_path.name}")

    try:
        df = pd.read_csv(file_path, low_memory=False)

        print(f"Rows: {len(df):,}")
        print(f"Columns: {len(df.columns)}")
        print("Column names:")
        print(df.columns.tolist())
        print(f"Duplicate rows: {df.duplicated().sum():,}")
        print(f"Missing values: {df.isna().sum().sum():,}")

    except Exception as error:
        print(f"ERROR reading file: {error}")

    print("-" * 80)
