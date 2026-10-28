# E-commerce Revenue & Customer Intelligence

**An end-to-end analytics portfolio project using Python, MySQL, SQL, and Power BI.**

> **Dataset scope:** This project analyzes an anonymized Brazilian e-commerce marketplace dataset covering approximately September 2016 to October 2018. It is not an India-specific dataset.

## Project Overview

This project investigates order and payment performance, delivery operations, repeat purchasing, and customer experience. The goal is to turn validated transaction-level data into actionable business insights while maintaining reproducible analysis and transparent data-quality checks.

### Key highlights

- Integrated and analyzed nine related e-commerce datasets.
- Built a relational data model in MySQL.
- Developed SQL analyses covering revenue, orders, customers, products, sellers, geography, delivery performance, and repeat purchasing.
- Reconciled payment totals across detailed and monthly aggregations.
- Created a five-page interactive Power BI report.
- Documented analytical findings, metric definitions, and business recommendations.



## Business Questions

- How do recorded item values, freight values, payment values, and order statuses compare?
- Which operational segments experience longer delivery delays?
- How frequently do customers place repeat orders?
- How are review scores associated with delivery performance and product categories?
- Which patterns merit further investigation by business stakeholders?

## Technology Stack

| Tool | Purpose|
|---|---|
| **Python** | Data profiling, validation, analysis, and metric reconciliation |
| **MySQL**  | Relational data storage, transformations, and analytical queries |
| **SQL** | Joins, CTEs, aggregations, window functions, and business metrics |
| **Power BI** | Interactive reporting and decision support |
| **DAX** | KPI and analytical measure calculations |
| **Git & GitHub** | Version control, documentation, and progress tracking |

## Project Timeline

| Day | Planned work | Status |
|---|---|---|
| 1 | Dataset inventory and initial validation | Completed |
| 2 | Business questions, data dictionary, and table grain | Completed |
| 3-5 | Python pipeline, MySQL schema, data loading, and SQL validation | Completed |
| 6-8 | Revenue, order, and delivery analysis | Completed |
| 9-10 | Customer intelligence and repeat purchasing | Completed |
| 11-12 | Statistical investigation and evidence checks | Completed |
| 13-15 | Power BI report and core release | Completed |
| 16-18 | Technical polish and justified extensions | Completed |
| 19-20 | Documentation, findings, screenshots, and interview preparation | Completed |


## Data Model & Validation

The analysis uses nine related datasets covering customers, orders, order items, products, sellers, payments, reviews, and product category translations, along with the remaining supporting source data.

**Data preparation and validation included:**
1. Loading datasets into MySQL.
2. Checking source row counts.
3. Reviewing relationships and join behavior.
4. Reconciling payment values across detailed and monthly aggregations.
5. Defining business metrics consistently for SQL analysis and Power BI reporting.

## Repository Structure

```text
ecommerce-revenue-customer-intelligence/
├── docs/
│   ├── E-Commerce_Revenue_Customer_Intelligence_Project_Report.docx
|   ├── Project_Progress_Log.docx
|   └── dashboard_screenshots/
|       ├── page-1-executive-overview.png
|       ├── page-2-revenue-product.png
|       ├── page-3-customer-intelligence.png
|       ├── page-4-delivery-performance.png
|       └── page-5-category-performance.png
├── sql/
│   ├── 01_revenue_order_analysis.sql
│   ├── 02_product_category_analysis.sql
|   ├── 03_customer_intelligence.sql
|   ├── 04_delivery_performance.sql
|   ├── 05_customer_experience_analysis.sql
|   ├── 06_seller_performance_analysis.sql
|   ├── 07_geographic_analysis.sql
|   ├── 08_customer_purchasing_behavior.sql
|   ├── 09_repeat_purchase_timing.sql
│   └── 10_data_quality_validation.sql
├── reports/
|   ├── business_questions.md
│   ├── data_model.md
│   ├── revenue_order_validation.md
│   ├── delivery_performance_findings.md
│   ├── customer_experience_findings.md
│   ├── seller_performance_findings.md
│   ├── geographic_analysis_findings.md
│   ├── customer_purchasing_behavior_findings.md
│   └── repeat_purchase_analysis.md
├── outputs/
|   ├── data_dictionary.csv
|   ├── dataset_inventory.csv
|   └── missing_values_report.csv
├── powerbi/
|   └── Ecommerce_Revenue_Customer_Intelligence_Dashboard.pbix
├── src/
|   ├── create_data_dictionary.py
|   ├── create_data_quality
|   ├── inspect_dataset.py
|   ├── inspect_mapping_issue.py
|   ├── inspect_review_duplicates.py
|   ├── prepare_reviews_for_mysql.py
|   ├── validate_dataset.py
|   └── validate_relationships.py
└── README.md
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

 For a day-by-day record of project development, including completed tasks, analytical findings, validation checks, deliverables, and pending work, see [`docs/Project_Progress_Log.docx`](docs/Project_Progress_Log.docx).

### Day 1 — Dataset Inventory and Initial Validation
- Identified and reviewed the nine source datasets.
- Inspected dataset structures, columns, row counts, and key fields.
- Checked data quality and prepared the datasets for further analysis.

**Status:** Completed

### Day 2 — Business Questions, Data Dictionary, and Table Grain
- Defined the project's analytical scope and key business questions.
- Documented the data model and table grain.
- Created a data dictionary to describe the available fields and their analytical purpose.
- Identified key relationships between customers, orders, products, sellers, payments, and reviews.

**Status:** Completed

### Days 3–5 — Python Pipeline, MySQL Schema, Data Loading, and SQL Validation
- Prepared the data analysis workflow using Python and MySQL.
- Created the `ecommerce_analytics` database and loaded the nine source datasets.
- Validated table row counts and reviewed key relationships.
- Checked joins and data consistency before conducting business analysis.

**Status:** Completed

### Days 6–8 — Revenue, Order, and Delivery Analysis
- Analyzed payment values, order volumes, and monthly trends.
- Investigated delivery performance, late deliveries, and customer experience indicators.
- Reconciled detailed payment records against monthly payment totals.
- Confirmed a monthly reconciliation difference of R$0.00 and identified one order without a payment record.

**Status:** Completed

### Days 9–10 — Customer Intelligence and Repeat Purchasing
- Analyzed unique, one-time, and repeat customers.
- Calculated the repeat-customer rate and repeat-purchase intervals.
- Examined repeat-purchase timing, including same-day and shorter-interval purchases.
- Explored customer purchasing behavior and geographic distribution.

**Status:** Completed

### Days 11–12 — Statistical Investigation and Evidence Checks
- Investigated customer purchasing patterns and repeat-purchase timing.
- Validated analytical outputs against supporting SQL queries.
- Checked payment reconciliation, record counts, and consistency of key business metrics.
- Documented findings and supporting evidence in the reports directory.

**Status:** Completed

### Days 13–15 — Power BI Report and Core Release
- Built a five-page Power BI report covering executive overview, revenue and product performance, customer intelligence, delivery performance, and category performance.
- Added KPI cards, charts, slicers, and category-level comparisons.
- Verified the data model relationships and reviewed visual titles, labels, and formatting.
- Saved dashboard screenshots for project documentation.

**Status:** Completed

### Days 16–18 — Technical Polish and Justified Extensions
- Review SQL scripts, data validation logic, and analytical metric definitions.
- Check consistency between SQL findings and Power BI measures.
- Review repository organization and identify opportunities for justified analytical improvements.

**Status:** Completed

### Days 19–20 — Documentation, Findings, Screenshots, and Interview Preparation
- Prepare a consolidated README describing the project, technology stack, findings, and dashboard.
- Verify dashboard screenshot paths and repository links.
- Finalize business recommendations and document analytical limitations.
- Prepare a concise project explanation for portfolio reviews and interviews.

**Status:** Completed

## SQL Analysis

The project includes ten SQL analysis scripts covering:

1. Revenue and order analysis
2. Product and category performance
3. Customer intelligence and repeat purchasing
4. Delivery performance
5. Customer experience and review analysis
6. Seller performance
7. Geographic analysis
8. Customer purchasing behavior and spending distributions
9. Repeat-purchase timing
10. Data quality and Relationship validation


Supporting documentation and outputs are available in the reports/ and outputs/ directories.


## Dashboard Preview
 
The Power BI report contains five pages designed to explore different aspects of e-commerce performance.

1. Executive Overview

<img width="725" height="404" alt="page-1-executive-overview" src="https://github.com/user-attachments/assets/5d609370-d7d4-469a-b45a-0ea0bdcfaafd" />


Highlights overall payment value, order volume, average order value, repeat-customer rate, monthly trends, and leading product categories.

2. Revenue & Product Performance

<img width="722" height="410" alt="page-2-revenue-product" src="https://github.com/user-attachments/assets/a5b01a80-b357-425a-9a07-45a45ee3b080" />


Explores product sales contribution, order-item volume by category, and the relationship between product prices and freight costs.

3. Customer Intelligence

<img width="722" height="406" alt="page-3-customer-intelligence" src="https://github.com/user-attachments/assets/10308037-4685-451b-ba80-8080eae3fbe9" />



Examines one-time versus repeat customers, repeat-purchase timing, and the geographic distribution of customers.

4. Order & Delivery Performance

<img width="721" height="407" alt="page-4-delivery-performance" src="https://github.com/user-attachments/assets/71fc3974-56b1-4d25-bd6f-1bd0944049ea" />


Evaluates delivery outcomes, late-delivery rates, monthly delivery times, and actual versus estimated delivery performance.

5. Category Performance

<img width="720" height="407" alt="page-5-category-performance" src="https://github.com/user-attachments/assets/f6078eed-b575-400a-b16a-c98a438f7b9e" />


Compares product categories by sales value, order-item volume, average item price, and contribution to total product sales.


## Key Business Findings

### Revenue & Payments

- Total recorded payment value: R$16,008,872.12
- Orders with payment records: 99,440
- Payment records: 103,886
- Orders with multiple payment records: 2,961
- Orders without a payment record: 1
- Unmatched payment records: 0
- Difference between detailed and monthly payment totals: R$0.00

Payment value represents recorded customer payments; it should not be interpreted as profit or accounting-recognized net revenue.

### Customer Retention

- Unique customers: 96,096
- One-time customers: 93,099
- Repeat customers: 2,997
- Repeat-customer rate: 3.12%
- Repeat-purchase events: 3,345
- Average interval between repeat purchases: 78.2 days

Approximately 51% of repeat-purchase events occurred within 30 days, including same-day events. This is an opportunity to investigate post-purchase engagement and customer retention.

### Geographic Performance

- São Paulo (SP) recorded 40,302 unique customers.
- São Paulo (SP) had 1,849 sellers in the analyzed dataset.

This concentration makes São Paulo an important market for further geographic and operational analysis.

### Delivery Performance

The dashboard tracks delivered-order rates, late-delivery rates, average delivery time, and actual versus estimated delivery time. These measures help identify delivery patterns that may affect customer experience.

*All findings describe the analyzed dataset and are not necessarily representative of current e-commerce market conditions.*

## Business Recommendations

Based on the observed patterns, the following areas merit further investigation:

1. Improve customer retention: Investigate why the repeat-customer rate is low and test post-purchase engagement strategies.

2. Analyze repeat-purchase timing: Evaluate customer cohorts and categories associated with shorter repeat-purchase intervals.

3. Monitor delivery reliability: Investigate late-delivery patterns by time period, geography, seller, and order characteristics.

4. Optimize category strategy: Compare category-level sales, order volume, and average item prices before making inventory or marketing decisions.

5. Maintain data quality: Continue validating payment totals, order relationships, and KPI definitions as the analysis expands.

These are analytical recommendations, not proven causal effects.



## Dataset Attribution and License

Source: Olist Brazilian E-Commerce Public Dataset  
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

The dataset is distributed under the **CC BY-NC-SA 4.0** license. Review the original license and attribution requirements before redistributing or publishing derived material. The original raw CSV files are not included in this repository.


#### How to Use the Dashboard

1. **Download the project:** Clone or download this GitHub repository.
2. **Open Power BI:** Open `powerbi/Ecommerce_Revenue_Customer_Intelligence_Dashboard.pbix` using Power BI Desktop.
3. **Start with the overview:** Review the headline KPIs, monthly payment trends, and leading product categories.
4. **Explore the dashboard pages:** Navigate through the available pages to analyse product performance, customer intelligence, delivery performance, and category performance.
5. **Apply filters:** Use the available slicers, such as year and order status where applicable, to explore different segments of the data.
6. **Interact with visuals:** Select chart elements to explore related information across connected visuals.
7. **Review the insights:** Use the dashboard alongside the project documentation to understand the findings and their limitations.

**Requirements:** Microsoft Power BI Desktop. Additional setup may be required if the report's data sources need to be configured or refreshed.

**Important:** Recorded payment value represents payment transactions in the dataset; it should not be interpreted as profit or net recognized revenue.




## Project Status

**Dashboard and Repository: Completed**

The five-page Power BI dashboard, 10 SQL analysis scripts, dashboard screenshots, and README documentation have been published to GitHub.

**Remaining Deliverable:** A detailed Word project report (`.docx`) covering the project objectives, dataset, data preparation, SQL analysis, dashboard design, key findings, business recommendations, and limitations.

The project will be considered fully documented once the final report is completed and added to the repository.

## Author

**Mukesh Samarit**
Aspiring Data Analyst | SQL · Python · Power BI · MySQL

**GitHub:** https://www.github.com/MSDIAN

**LinkedIn:** https://www.linkedin.com/in/mukesh-samarit

**PortFolio:** https://mukesh-portfolio-navy.vercel.app/
