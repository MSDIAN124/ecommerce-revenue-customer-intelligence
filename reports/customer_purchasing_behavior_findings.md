# Customer Purchasing Behavior — Findings

## 1. Objective

Analyze order payment values and customer spending patterns using the Brazilian E-Commerce Public Dataset by Olist. The analysis covers average order value, order value distribution, zero-value orders, delivered-order payment values, and customer spending segments.

## 2. Overall Order Payment Value

| Metric | Result |
|---|---:|
| Orders with recorded payments | 99,440 |
| Average payment value per order | 160.99 |
| Minimum payment value per order | 0.00 |
| Maximum payment value per order | 13,664.08 |
| Total recorded payment value | 16,008,872.12 |

**Finding:** The average recorded payment value was 160.99 per order among orders with payment records.

This is a payment-based metric, not profit or net recognized revenue.

## 3. Order Value Distribution

| Order Value Band | Orders | Percentage |
|---|---:|---:|
| Zero | 3 | 0.00% |
| Under 50 | 16,907 | 17.00% |
| 50–99.99 | 30,345 | 30.52% |
| 100–249.99 | 38,476 | 38.69% |
| 250–499.99 | 9,413 | 9.47% |
| 500 and above | 4,296 | 4.32% |

**Finding:** The 100–249.99 band is the largest group, representing 38.69% of orders with recorded payments. Approximately 69.21% of orders fall in the 50–249.99 range.

The displayed percentages are rounded and may not sum to exactly 100%.

## 4. Zero-Value Order Investigation

Three orders had a total recorded payment value of zero.

| Order ID | Payment Records | Payment Type | Order Status |
|---|---:|---|---|
| `00b1cb0320190ca0daa2c88b35206009` | 1 | not_defined | canceled |
| `4637ca194b6387e2d538dc89b124b0ee` | 1 | not_defined | canceled |
| `c8c528189310eaa44a745b8d9d26908b` | 1 | not_defined | canceled |

**Finding:** All three zero-value orders were canceled and had `not_defined` as their payment type.

These records were retained in the dataset. They should not automatically be treated as data errors or deleted.

## 5. Delivered-Order Payment Value

| Metric | Result |
|---|---:|
| Delivered orders with recorded payments | 96,477 |
| Average payment value per delivered order | 159.86 |
| Minimum payment value | 9.59 |
| Maximum payment value | 13,664.08 |
| Total recorded payment value | 15,422,461.77 |

**Finding:** Delivered orders with payment records had an average recorded payment value of 159.86.

One delivered order had no payment record and was excluded from this payment-based calculation.

## 6. Customer-Level Spending

| Metric | Result |
|---|---:|
| Unique customers with recorded payments | 96,095 |
| Average recorded spend per customer | 166.59 |
| Minimum customer spend | 0.00 |
| Maximum customer spend | 13,664.08 |
| Average orders per customer in this subset | 1.03 |

**Finding:** The average recorded spending per customer was 166.59 among customers with linked orders and payment records.

This customer-level metric differs from average order value because it aggregates payment values at the unique-customer level.

## 7. Customer Spending Distribution

| Customer Spending Band | Customers | Percentage |
|---|---:|---:|
| Zero | 2 | 0.00% |
| Under 100 | 44,388 | 46.19% |
| 100–249.99 | 37,457 | 38.98% |
| 250–499.99 | 9,759 | 10.16% |
| 500 and above | 4,489 | 4.67% |

**Finding:** Approximately 85.17% of customers with recorded payments had total recorded spending below 250. Customers spending 500 or above represented 4.67% of this population.

The two zero-spend customers are retained because their linked payment records sum to zero.

## 8. Business Implications

- **Order-value monitoring:** The 100–249.99 band is the largest order-value segment and may be useful for monitoring typical transaction values.
- **Customer segmentation:** Spending bands can support descriptive customer segmentation in a Power BI dashboard.
- **Payment quality checks:** Zero-value orders and orders without payment records should be monitored separately from completed-purchase metrics.
- **Metric clarity:** Payment-based order value, delivered-order payment value, customer spending, and item-price-based sales should remain separate metrics.

These findings describe the historical dataset and do not establish causation or predict future customer behavior.

## 9. Methodology and Limitations

- Payment records were aggregated to order level before calculating order-level metrics.
- Customer spending was aggregated using `customer_unique_id`.
- Order value bands and customer spending bands are descriptive categories, not official business thresholds.
- Customer spending metrics include recorded payments across order statuses.
- Orders without payment records are excluded from payment-based calculations.
- Recorded payments are not equivalent to profit or net recognized revenue.
- Monetary values are reported in the dataset's units; no currency symbol has been assumed.

## 10. Files

- SQL analysis: `sql/08_customer_purchasing_behavior.sql`
- Findings: `reports/customer_purchasing_behavior_findings.md`
 