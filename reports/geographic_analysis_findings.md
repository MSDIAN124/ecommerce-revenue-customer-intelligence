# Geographic Analysis — Findings

## 1. Objective

Analyze customer and seller geographic distribution in the Brazilian E-Commerce Public Dataset by Olist. The analysis examines customer concentration, state-level delivered product sales, seller distribution, and same-state versus cross-state seller-customer transactions.

## 2. Customer Geographic Distribution

The customer dataset contains 96,096 unique customers across the reported states.

The leading states by unique customers are:

| State | Customer Records | Unique Customers | Cities Covered |
|---|---:|---:|---:|
| SP | 41,746 | 40,302 | 629 |
| RJ | 12,852 | 12,384 | 149 |
| MG | 11,635 | 11,259 | 745 |
| RS | 5,466 | 5,277 | 379 |
| PR | 5,045 | 4,882 | 364 |

**Finding:** São Paulo (SP) has the largest customer base, followed by Rio de Janeiro (RJ) and Minas Gerais (MG). SP represents approximately 42% of the dataset's unique customers.

City counts refer to distinct city labels recorded in the dataset and should not be interpreted as measures of geographic size.

## 3. State-Wise Delivered Product Sales

The highest-selling customer states by delivered product sales are:

| State | Delivered Orders | Delivered Product Sales | Freight Value |
|---|---:|---:|---:|
| SP | 40,501 | 5,067,633.16 | 702,069.99 |
| RJ | 12,350 | 1,759,651.13 | 295,750.44 |
| MG | 11,354 | 1,552,481.83 | 266,409.84 |
| RS | 5,345 | 728,897.47 | 132,575.32 |
| PR | 4,923 | 666,063.51 | 115,645.29 |

**Finding:** SP leads in both customer volume and delivered product sales. Its product sales are approximately 2.88 times those of RJ.

**Metric definition:** Delivered product sales are calculated as the sum of item prices for delivered orders, excluding freight. These figures do not represent profit or net recognized revenue.

## 4. Seller Geographic Distribution

The states with the largest seller presence are:

| State | Sellers | Cities Covered |
|---|---:|---:|
| SP | 1,849 | 260 |
| PR | 349 | 67 |
| MG | 244 | 82 |
| SC | 190 | 65 |
| RJ | 171 | 38 |
| RS | 129 | 51 |

**Finding:** SP accounts for approximately 59.7% of the 3,095 sellers in the dataset. Paraná (PR) and Minas Gerais (MG) follow.

The concentration of both customers and sellers in SP makes it an important geographic market in this dataset. This does not establish that SP sellers primarily serve SP customers.

## 5. Same-State vs Cross-State Transactions

| Metric | Cross-State | Same-State |
|---|---:|---:|
| Delivered orders associated with sellers | 61,898 | 34,827 |
| Order-item records | 70,331 | 39,866 |
| Product sales | 9,087,193.44 | 4,134,304.67 |
| Freight value | 1,662,101.55 | 536,174.09 |

**Finding:** Cross-state seller-item transactions account for approximately 68.7% of product sales in this comparison. Cross-state freight value is also higher in aggregate.

These totals describe transactions between customer and seller states. They do not establish that an individual cross-state shipment is more expensive than a same-state shipment; a per-order or per-item comparison would be needed for that conclusion.

## 6. Business Implications

- **Market prioritization:** SP is a strong candidate for deeper category, customer, and seller analysis because it has the largest customer and seller presence.
- **Logistics analysis:** Cross-state transactions represent a substantial share of product sales and may warrant further investigation into delivery times and freight costs.
- **Regional planning:** RJ and MG are the next major customer markets by volume and delivered product sales.
- **Dashboard design:** State-level customer counts, delivered product sales, seller counts, and same-state versus cross-state sales can support geographic Power BI visuals.

These are descriptive findings, not causal conclusions or recommendations to change operations without additional analysis.

## 7. Methodology and Limitations

- Customer distribution uses `customer_unique_id` for unique-customer counts.
- Delivered product sales use `order_items.price` for delivered orders; freight is shown separately.
- Seller distribution uses the seller's recorded state and city.
- Same-state and cross-state classifications compare `customer_state` and `seller_state`.
- Orders can contain items from multiple sellers. An order may therefore appear in both geography groups, so group order counts must not be added as if they were mutually exclusive.
- The raw geolocation table was not joined directly because ZIP prefixes can map to multiple coordinate records.
- The dataset is historical and represents the Olist dataset's coverage, not necessarily the present-day Brazilian e-commerce market.

## 8. Files

- SQL analysis: `sql/07_geographic_analysis.sql`
- Findings: `reports/geographic_analysis_findings.md`
