# Customer Experience & Review Analysis

## Objective

Analyze customer review ratings and examine their association with delivery timeliness using the Olist Brazilian E-Commerce dataset.

## 1. Review Data Baseline

| Metric | Result |
|---|---:|
| Total review records | 99,224 |
| Distinct orders reviewed | 98,673 |
| Average review score | 4.09 / 5 |
| 1-star reviews | 11,424 |
| 5-star reviews | 57,328 |
| Reviews without written comments | 58,274 |

Review records and distinct orders are different measures. Review IDs should not be assumed unique, and records should not be deleted without investigating their grain.

## 2. Review Score Distribution

| Review score | Records | Percentage |
|---|---:|---:|
| 1 star | 11,424 | 11.51% |
| 2 stars | 3,151 | 3.18% |
| 3 stars | 8,179 | 8.24% |
| 4 stars | 19,142 | 19.29% |
| 5 stars | 57,328 | 57.78% |

### Key findings

- Five-star reviews represent 57.78% of review records.
- Low ratings (1–2 stars combined) represent 14.69%.
- Four- and five-star reviews combined represent 77.07%.
- The overall average review score is 4.09 out of 5.

## 3. Review Ratings by Delivery Timeliness

| Delivery group | Review records | Average rating | Low-rating percentage |
|---|---:|---:|---:|
| Delivery dates unavailable | 2,865 | 1.76 | 77.66% |
| Late delivery | 7,701 | 2.57 | 54.02% |
| On-time delivery | 88,658 | 4.29 | 9.24% |

Low ratings are defined as review scores of 1 or 2.

### Key findings

- Orders classified as delivered on time have an average review score of 4.29, compared with 2.57 for late deliveries.
- The low-rating share is 54.02% for late deliveries and 9.24% for on-time deliveries.
- The unavailable-date group has a low average rating of 1.76 and a low-rating share of 77.66%. This group requires separate investigation because it may contain incomplete or non-standard order outcomes.

## Business Implications

Delivery timeliness is strongly associated with customer review outcomes in this dataset. Delivery performance is therefore a useful area for further investigation when assessing customer experience.

The unavailable-date group should be investigated separately to understand its composition. Additional analysis by purchase month, product category, seller, or customer location may help identify patterns for further study.

## Methodology and Limitations

- Review ratings are analyzed at the review-record level.
- Multiple review records associated with an order are preserved.
- Low ratings are defined as scores of 1–2.
- Missing written comments are not treated as invalid ratings.
- Delivery groups are based on actual versus estimated delivery timestamps.
- The findings describe associations and do not establish causation.
- Orders without usable delivery dates should not automatically be interpreted as delivered late.

