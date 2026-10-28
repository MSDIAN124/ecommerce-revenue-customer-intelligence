# Data Quality Validation

## Objective
Validate product and seller references in the `order_items` dataset by checking whether each referenced product and seller exists in its corresponding source table.

## Validation Checks

| Check | Result |
|---|---:|
| Order items checked | 112,650 |
| Unmatched product IDs | 0 |
| Unmatched seller IDs | 0 |

## Key Findings
- All 112,650 order-item records reference existing products.
- All 112,650 order-item records reference existing sellers.
- No unmatched product or seller references were identified in these checks.

## Conclusion
Both product-reference and seller-reference validation checks passed. These results support the integrity of these two relationships within the order-item data.

**Scope limitation:** These checks validate only product and seller references in `order_items`. They do not establish that every table, column, or business rule in the full dataset is free from data-quality issues.

## Related SQL
[`10_data_quality_validation.sql`](../sql/10_data_quality_validation.sql)
