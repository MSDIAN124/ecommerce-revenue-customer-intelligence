# Seller Performance Analysis

## Objective

Evaluate seller-level order volume, delivered product sales, delivery timeliness, and customer review patterns using the Olist Brazilian E-Commerce dataset.

## 1. Seller Data Baseline

| Metric | Result |
|---|---:|
| Total sellers | 3,095 |
| Sellers with order items | 3,095 |
| Total order-item records | 112,650 |
| Distinct orders containing items | 98,666 |
| Seller–order combinations | 100,010 |

Seller–order combinations exceed distinct orders because a single order can contain items from multiple sellers. Seller-level order counts can therefore overlap.

## 2. Top Sellers by Delivered Product Sales

| Seller ID (shortened) | Delivered orders | Order items | Product sales value | Freight value |
|---|---:|---:|---:|---:|
| `4869f7a5...` | 1,124 | 1,148 | 226,987.93 | 20,019.13 |
| `53243585...` | 348 | 400 | 217,940.44 | 12,856.58 |
| `4a3ca931...` | 1,772 | 1,949 | 196,882.12 | 34,338.31 |
| `fa1c13f2...` | 578 | 579 | 190,917.14 | 9,916.36 |
| `7c67e144...` | 973 | 1,355 | 186,570.05 | 51,236.64 |

### Key findings

- Seller `4869f7a5...` recorded the highest product sales value in the top-10 result: 226,987.93.
- Seller `4a3ca931...` handled the highest delivered order volume in that result, with 1,772 orders.
- Seller `7c67e144...` recorded the highest freight value among the displayed top 10.

Product sales value is the sum of item prices and excludes freight. It does not represent profit or net recognized revenue.

## 3. Seller-Wise Delivery Performance

The analysis included sellers with at least 50 delivered orders for which both actual and estimated delivery dates were available.

### Highest late-delivery rates in the returned top 10

| Seller ID (shortened) | Eligible orders | Late orders | Late-delivery rate |
|---|---:|---:|---:|
| `54965bbe...` | 73 | 22 | 30.14% |
| `a49928bc...` | 96 | 25 | 26.04% |
| `beadbee3...` | 64 | 16 | 25.00% |
| `06a2c3af...` | 389 | 90 | 23.14% |
| `cac4c8e7...` | 74 | 17 | 22.97% |

Seller `06a2c3af...` had 90 late orders out of 389 eligible orders, making its late-delivery result notable in absolute volume as well as percentage terms.

These results identify sellers for further investigation; they do not establish that the seller alone caused delivery delays.

## 4. Seller-Associated Customer Review Ratings

The review analysis retained multiple review records and associated order-level reviews with sellers represented in each order.

| Seller ID (shortened) | Reviewed orders | Average rating | Low-rating percentage |
|---|---:|---:|---:|
| `1ca7077d...` | 107 | 2.27 | 63.49% |
| `2eb70248...` | 184 | 2.81 | 47.69% |
| `972d0f9c...` | 79 | 2.96 | 44.05% |
| `a49928bc...` | 96 | 2.97 | 43.27% |
| `8e6d7754...` | 84 | 3.03 | 43.94% |

Low ratings are defined as review scores of 1 or 2.

### Key findings

- Seller `1ca7077d...` had the lowest average rating in the returned top-10 result, at 2.27, with 63.49% low ratings.
- Seller `a49928bc...` appears in both the high late-delivery-rate and low-rating results.
- Seller `54965bbe...` also appears in both results, making it another candidate for further investigation.

These are seller-associated order ratings, not necessarily direct ratings of an individual seller or product. Multi-seller orders can associate the same review with more than one seller.

## Business Implications

The analysis reveals differences in seller order volume, product sales, late-delivery rates, and associated review outcomes. These metrics can help prioritize further investigation into seller-related fulfillment and customer-experience patterns.

Before drawing operational conclusions, additional checks should account for order volume, seller mix, geography, and the overlap of order-level reviews across sellers.

## Methodology and Limitations

- Sales and delivery metrics are based on delivered orders.
- Product sales are calculated from item prices; freight is reported separately.
- Delivery performance includes orders with both actual and estimated delivery timestamps.
- Seller-level order counts may overlap because orders can contain items from multiple sellers.
- Reviews are recorded at order level and may be associated with multiple sellers.
- Findings are descriptive and do not establish causation or seller profitability.
