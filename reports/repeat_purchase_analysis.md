# Repeat Purchase Timing Analysis

## 1. Objective

Analyze the time between consecutive purchases made by the same customer to understand observed repeat-purchase patterns in the Olist Brazilian E-commerce dataset.

## 2. Methodology

- Identified customers using `customer_unique_id` to track purchases across customer records.
- Ordered purchases chronologically using `order_purchase_timestamp` and `order_id`.
- Used SQL window functions (`ROW_NUMBER()` and `LAG()`) to identify consecutive purchases.
- Calculated the gap in calendar days using `DATEDIFF()`.
- Grouped repeat-purchase events into six time intervals.

**Scope:** The analysis includes orders with a non-null purchase timestamp, regardless of order status. Results reflect the available dataset period and should not be interpreted as lifetime retention metrics.

## 3. Key Results

| Metric | Result |
|---|---:|
| Repeat-purchase events | 3,345 |
| Customers with repeat purchases | 2,997 |
| Average gap between purchases | 78.2 days |
| Minimum gap | 0 days |
| Maximum gap | 609 days |

### Purchase-Gap Distribution

| Gap between purchases | Events | Share |
|---|---:|---:|
| 0 days | 961 | 28.73% |
| 1–30 days | 745 | 22.27% |
| 31–60 days | 390 | 11.66% |
| 61–90 days | 229 | 6.85% |
| 91–180 days | 479 | 14.32% |
| 181+ days | 541 | 16.17% |
| **Total** | **3,345** | **100.00%** |

## 4. Business Insights

- **51.00%** of repeat-purchase events occurred within 30 days, including same-day purchases.
- **28.73%** of events occurred on the same calendar day. These may represent separate orders placed on the same day rather than separate shopping sessions.
- **30.49%** of repeat-purchase events occurred after more than 90 days.
- The observed purchase gaps vary considerably, indicating that repeat-purchase timing is not uniform across customers.

## 5. Business Recommendations

- Explore customer segmentation based on observed purchase frequency and recency.
- Investigate same-day multiple orders separately before interpreting them as distinct shopping occasions.
- Consider testing re-engagement campaigns for customers with longer purchase gaps, subject to suitable customer-level validation.
- Combine this analysis with product-category and customer-spending insights to investigate which segments are most relevant for retention initiatives.

## 6. Limitations

- The dataset covers a limited historical period, so the results do not represent customers' complete lifetime behavior.
- The analysis measures time between recorded orders, not the probability of a future purchase.
- Same-day gaps are calculated using calendar dates and do not measure elapsed hours.
- The results are descriptive and do not establish that any particular marketing action will improve retention.

## 7. Tools Used

- MySQL
- SQL window functions: `ROW_NUMBER()` and `LAG()`
- Date calculation: `DATEDIFF()`
- Aggregation and percentage-based analysis
