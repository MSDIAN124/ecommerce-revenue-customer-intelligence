# E-commerce Revenue & Customer Intelligence

**An end-to-end analytics portfolio project using Python, MySQL, SQL, and Power BI.**

> **Dataset scope:** This project analyzes an anonymized Brazilian e-commerce marketplace dataset covering approximately September 2016 to October 2018. It is not an India-specific dataset.

## Project Overview

This project investigates order and payment performance, delivery operations, repeat purchasing, and customer experience. The goal is to turn validated transaction-level data into actionable business insights while maintaining reproducible analysis and transparent data-quality checks.

## Business Questions

- How do recorded item values, freight values, payment values, and order statuses compare?
- Which operational segments experience longer delivery delays?
- How frequently do customers place repeat orders?
- How are review scores associated with delivery performance and product categories?
- Which patterns merit further investigation by business stakeholders?

## Technology Stack

- **Python:** Data profiling, validation, analysis, and metric reconciliation
- **MySQL:** Relational data storage, transformations, and analytical queries
- **SQL:** Joins, CTEs, aggregations, window functions, and business metrics
- **Power BI:** Interactive reporting and decision support
- **Git & GitHub:** Version control, documentation, and progress tracking

## Project Timeline

| Day | Planned work | Status |
|---|---|---|
| 1 | Dataset inventory and initial validation | Completed |
| 2 | Business questions, data dictionary, and table grain | In progress |
| 3–5 | Python pipeline, MySQL schema, data loading, and SQL validation | Planned |
| 6–8 | Revenue, order, and delivery analysis | Planned |
| 9–10 | Customer intelligence and repeat purchasing | Planned |
| 11–12 | Statistical investigation and evidence checks | Planned |
| 13–15 | Power BI report and core release | Planned |
| 16–18 | Technical polish and justified extensions | Planned |
| 19–20 | Documentation, findings, screenshots, and interview preparation | Planned |

## Repository Structure

```text
data/
  raw/                 # Local only; excluded from Git
  processed/           # Local working data; excluded from Git
src/                   # Python scripts
notebooks/             # Exploratory analysis
sql/                   # Schema and analytical queries
powerbi/               # Power BI project files
reports/               # Documentation and findings
outputs/               # Selected, reviewed analytical outputs
tests/                 # Data and metric validation tests
```

## Data Quality and Methodology

Initial checks cover file inventory, missing values, duplicate records, key uniqueness, foreign-key matches, and category mappings. Additional checks will validate date logic, table grain, join cardinality, and metric reconciliation.

Important principles:

- Preserve original source files unchanged.
- Do not assume that missing values always indicate errors.
- Do not assume repeated identifiers always represent duplicate records.
- Avoid joins that multiply item, payment, or review records.
- Do not equate recorded item value with profit or treat every canceled order as a realized financial loss.
- Separate observed associations from causal explanations.
- Document limitations and unresolved data-quality issues.

## Progress Log

Daily updates will record work completed, checks performed, outcomes, issues discovered, deliverables, and the next planned steps.

### Day 1 — Dataset Inventory and Initial Validation

**Completed**
- Identified all nine source CSV files.
- Created a Python virtual environment and installed pandas.
- Generated dataset inventory and missing-value reports.
- Checked key uniqueness and foreign-key relationships.
- Investigated repeated review IDs, category mapping exceptions, and geolocation duplication.
- Defined the initial business questions.

**Key findings**
- Orders: 99,441 rows.
- Order items: 112,650 rows.
- Payments: 103,886 rows.
- Reviews: 99,224 rows.
- The geolocation source contains 1,000,163 rows, including 261,831 exact duplicate rows.
- Review IDs and category translations require careful handling.
- All tested order/customer/item/payment/review/seller/product ID relationships had zero unmatched child IDs, except for two product categories without English translations.

**Open items**
- Investigate review identifier behavior.
- Define table grain and safe join paths.
- Choose an appropriate geolocation mapping strategy.
- Complete the data dictionary and schema design.

### Day 2 — Data Modeling and MySQL Setup

**Completed**
- Documented table grain, primary/composite keys, relationships, and safe join considerations in `reports/data_model.md`.
- Generated `outputs/data_dictionary.csv`, documenting 9 datasets and 52 columns.
- Created the `ecommerce_analytics` database in MySQL 8.0.
- Created and populated all nine relational tables.
- Imported and verified all source datasets against their expected row counts.
- Executed six foreign-key integrity checks; all returned zero unmatched rows.

**Database validation results**

| Table | Rows loaded |
|---|---:|
| Customers | 99,441 |
| Orders | 99,441 |
| Order items | 112,650 |
| Order payments | 103,886 |
| Order reviews | 99,224 |
| Products | 32,951 |
| Sellers | 3,095 |
| Category translation | 71 |
| Geolocation | 1,000,163 |

**Key modeling decisions**
- Use `customer_unique_id` to identify customers across multiple customer records.
- Preserve order items, payment records, and reviews at their appropriate levels of detail.
- Avoid directly joining order items and payments before aggregation, as this can inflate totals.
- Account for duplicate geolocation prefixes before using geolocation in analytical joins.
- Preserve review records even when review IDs repeat; do not assume `review_id` is unique.

**Open items**
- Complete further data-quality checks, including key uniqueness and value/date validation.
- Define and validate SQL business metrics.
- Reconcile revenue and order metrics before building Power BI visuals.

## Day 3 — SQL Business Analysis & Customer Intelligence

**Objective:** Use SQL to analyze revenue, order behavior, product categories, customer retention, delivery performance, and customer experience.

**Work completed:**
- Created SQL analysis scripts for revenue and order analysis.
- Analyzed product and category performance.
- Investigated customer purchasing frequency and repeat-customer behavior.
- Evaluated delivery performance and customer review patterns.
- Documented delivery and customer experience findings.

**Key findings:**
- Identified 96,096 unique customers.
- Found 2,997 repeat customers, representing a repeat-customer rate of approximately 3.12%.
- Identified the distribution of customers by number of orders.

**Deliverables:**
- `sql/01_revenue_order_analysis.sql`
- `sql/02_product_category_analysis.sql`
- `sql/03_customer_intelligence.sql`
- `sql/04_delivery_performance.sql`
- `sql/05_customer_experience_analysis.sql`
- `reports/delivery_performance_findings.md`
- `reports/customer_experience_findings.md`

**Skills practiced:** SQL aggregations, joins, customer-level analysis, business metrics, and analytical reporting.

---

## Day 4 — Seller Performance Analysis

**Objective:** Evaluate seller performance using sales, delivery timeliness, and customer review indicators.

**Work completed:**
- Developed SQL queries to analyze seller-level performance.
- Examined seller-associated product sales.
- Analyzed late-delivery patterns.
- Evaluated customer ratings associated with sellers.
- Documented the findings and their potential business implications.

**Deliverables:**
- `sql/06_seller_performance_analysis.sql`
- `reports/seller_performance_findings.md`

**Skills practiced:** SQL joins, aggregations, seller-level KPIs, delivery analysis, and business reporting.

---

## Day 5 — Geographic Analysis

**Objective:** Understand customer and seller distribution across Brazilian states and investigate geographic patterns in sales and freight costs.

**Work completed:**
- Analyzed the geographic distribution of customers.
- Compared state-level customer counts.
- Evaluated seller distribution across states.
- Analyzed delivered product sales by customer state.
- Compared same-state and cross-state seller-to-customer transactions.
- Examined product sales and freight values across geographic transaction groups.

**Key findings:**
- Identified 96,096 unique customers in the customer dataset.
- São Paulo (SP) had the highest customer count, with 40,302 customers.
- São Paulo also had the largest seller presence, with 1,849 out of 3,095 sellers.
- Cross-state seller-item transactions recorded approximately 9.09 million in product sales and 1.66 million in freight values.
- Same-state seller-item transactions recorded approximately 4.13 million in product sales and 0.54 million in freight values.

**Deliverables:**
- `sql/07_geographic_analysis.sql`
- `reports/geographic_analysis_findings.md`

**Skills practiced:** Geographic segmentation, SQL aggregation, state-level comparisons, and freight analysis.

**Methodological note:** Same-state and cross-state figures are based on seller-item transaction groups. An order may contain items from multiple sellers, so these groups should not be interpreted as mutually exclusive unique-order counts.

---

## Day 6 — Customer Purchasing Behavior & Order Value Analysis

**Objective:** Analyze payment-based order values, delivered-order payment metrics, and customer spending distributions.

**Work completed:**
- Calculated average recorded payment value per order.
- Analyzed the distribution of orders across payment-value bands.
- Investigated zero-value orders and their associated payment types and order statuses.
- Calculated payment metrics for delivered orders.
- Aggregated recorded payments by unique customer.
- Segmented customers into spending bands.

**Key findings:**
- Analyzed 99,440 orders with recorded payment information.
- Average recorded payment value per order was approximately 160.99.
- Total recorded payment value across these orders was approximately 16.01 million.
- Orders in the 100–249.99 payment-value band formed the largest segment, accounting for approximately 38.69% of orders.
- Three zero-value orders were identified; all were canceled and associated with the `not_defined` payment type.
- Delivered orders with recorded payments had an average payment value of approximately 159.86.
- Among 96,095 customers with recorded payments, approximately 85.17% had total recorded payments below 250.

**Deliverables:**
- `sql/08_customer_purchasing_behavior.sql`
- `reports/customer_purchasing_behavior_findings.md`

**Skills practiced:** Order-level aggregation, customer-level spending analysis, conditional aggregation, distribution analysis, and business interpretation.

**Methodological notes:**
- Payment value is not equivalent to profit or net recognized revenue.
- Customer spending metrics include recorded payments across order statuses.
- Orders without payment records are excluded from payment-based calculations.
- Zero-value and canceled-order records are retained rather than removed from the source data.


## Dataset Attribution and License

Source: Olist Brazilian E-Commerce Public Dataset  
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

The dataset is distributed under the **CC BY-NC-SA 4.0** license. Review the original license and attribution requirements before redistributing or publishing derived material. The original raw CSV files are not included in this repository.

## Project Status

**In progress.** Final analytical findings, dashboard screenshots, metric reconciliation, and recommendations will be added after validation and implementation.

## Author

Mukesh Samarit

Data Analytics Portfolio Project
