# E-commerce Revenue & Customer Intelligence

## Project Objective

Analyze a real-world, anonymized Brazilian e-commerce marketplace dataset to evaluate order and payment performance, delivery operations, repeat purchasing, and customer experience. Identify measurable operational risk signals and translate the findings into actionable business recommendations.

## Business Questions

### 1. Revenue and Order Performance
- What are the total recorded item value, freight value, and payment value?
- How do order statuses vary over time?
- Are there differences between item totals and recorded payment totals that require investigation?

### 2. Delivery Performance
- What percentage of eligible delivered orders arrived after the estimated delivery date?
- How does delivery performance vary by seller, product category, and customer region?
- Which operational segments have the longest delivery delays?

### 3. Customer Intelligence
- What percentage of identified customers placed more than one order?
- How does purchasing frequency vary over time?
- Which customer groups have higher order frequency or recorded spending?

### 4. Customer Experience
- How are review scores distributed?
- How are review scores associated with delivery delays and order status?
- Which product categories or seller segments have comparatively lower review scores?

## Data and Methodology Principles

- Preserve original source files unchanged.
- Document dataset grain, keys, missing values, and join relationships.
- Reconcile metrics before publishing dashboard results.
- Do not equate item value with profit or assume every canceled order represents a realized financial loss.
- Distinguish observed relationships from causal explanations.
- Clearly disclose that the dataset represents a Brazilian marketplace and covers approximately September 2016 to October 2018.
- Review and comply with the dataset's stated license and attribution requirements before publishing or reusing derived material.

## Expected Deliverables

- Reproducible Python data-quality and validation scripts
- Documented MySQL schema and analytical SQL queries
- Reconciled Power BI dashboard
- Data dictionary, methodology, limitations, and business recommendations
- GitHub README with dataset attribution and project evidence