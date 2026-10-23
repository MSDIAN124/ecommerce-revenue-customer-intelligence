# Delivery Performance Analysis

## Objective
Evaluate delivery timeliness by comparing actual customer delivery timestamps against estimated delivery timestamps in the Olist Brazilian E-Commerce dataset.

## Overall Findings

| Metric | Result |
|---|---:|
| Total delivered orders | 96,478 |
| Orders with both delivery dates | 96,470 |
| Orders missing actual delivery date | 8 |
| On-time deliveries | 88,644 |
| Late deliveries | 7,826 |
| On-time delivery rate | 91.89% |
| Late delivery rate | 8.11% |
| Average delay among late orders | 8.87 days |
| Maximum delay | 188 days |

## Monthly Findings

- March 2018 recorded the highest late-delivery rate among the months returned by the analysis: **21.36%**, representing 1,496 late orders out of 7,003 evaluated deliveries.
- February 2018 recorded a late-delivery rate of **15.99%**.
- November 2017 recorded a late-delivery rate of **14.31%**.
- June 2018 recorded a comparatively low late-delivery rate of **1.36%**.

## Methodology

- The analysis includes orders with `order_status = 'delivered'`.
- On-time and late classifications use orders with both actual and estimated delivery timestamps available.
- An order is classified as late when its actual delivery timestamp is later than its estimated delivery timestamp.
- Monthly performance is grouped by purchase month, not delivery month.
- Delay duration is calculated using MySQL `TIMESTAMPDIFF(DAY, ...)`, which counts complete 24-hour periods.

## Data Limitations

- Eight delivered orders lack an actual delivery timestamp and are excluded from the on-time/late classification.
- The minimum delay reported as zero days can represent a delay shorter than 24 hours.
- Partial months may have incomplete order volumes.
- These findings are descriptive and do not establish the causes of delivery delays.

## Business Implications

The overall late-delivery rate provides a baseline for monitoring delivery performance. March 2018 and February 2018 warrant further investigation to understand whether the observed spikes relate to order mix, geography, sellers, or other operational factors. These potential explanations require additional analysis before any conclusions can be drawn.
