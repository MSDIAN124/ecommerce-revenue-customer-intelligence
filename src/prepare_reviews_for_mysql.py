
import csv
from pathlib import Path

source = Path("data/raw/olist_order_reviews_dataset.csv")
output = Path("data/processed/order_reviews_mysql.tsv")
output.parent.mkdir(parents=True, exist_ok=True)

expected_columns = [
    "review_id",
    "order_id",
    "review_score",
    "review_comment_title",
    "review_comment_message",
    "review_creation_date",
    "review_answer_timestamp",
]

rows_written = 0

with source.open("r", encoding="utf-8-sig", newline="") as infile:
    reader = csv.reader(infile)

    header = next(reader)
    if header != expected_columns:
        raise ValueError(f"Unexpected CSV columns: {header}")

    with output.open("w", encoding="utf-8", newline="") as outfile:
        for row in reader:
            if len(row) != len(expected_columns):
                raise ValueError(
                    f"Invalid record near CSV line {reader.line_num}: "
                    f"expected 7 fields, got {len(row)}"
                )

            # Keep every record on one physical line.
            # Replace tabs/newlines inside text fields with spaces.
            row = [
                value.replace("\t", " ").replace("\r", " ").replace("\n", " ")
                for value in row
            ]

            outfile.write("\t".join(row) + "\n")
            rows_written += 1

print(f"Rows prepared: {rows_written:,}")
print(f"Output file: {output}")
