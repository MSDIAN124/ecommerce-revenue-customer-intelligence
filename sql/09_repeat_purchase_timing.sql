-- ============================================================
-- Project: E-commerce Revenue & Customer Intelligence
-- Analysis: Repeat Purchase Timing
-- Database: ecommerce_analytics
-- Dataset: Olist Brazilian E-commerce Public Dataset
-- ============================================================

USE ecommerce_analytics;


-- ============================================================
-- QUERY 1: Overall Repeat Purchase Timing Metrics
-- Purpose:
-- Calculate repeat purchase events, repeat customers,
-- and the average, minimum, and maximum gap between purchases.
-- ============================================================



WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        o.order_id,
        DATE(o.order_purchase_timestamp) AS purchase_date,
        ROW_NUMBER() OVER (
            PARTITION BY c.customer_unique_id
            ORDER BY o.order_purchase_timestamp, o.order_id
        ) AS purchase_number,
        LAG(DATE(o.order_purchase_timestamp)) OVER (
            PARTITION BY c.customer_unique_id
            ORDER BY o.order_purchase_timestamp, o.order_id
        ) AS previous_purchase_date
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_purchase_timestamp IS NOT NULL
)
SELECT
    COUNT(*) AS repeat_purchase_events,
    COUNT(DISTINCT customer_unique_id) AS repeat_customers,
    ROUND(AVG(DATEDIFF(
        purchase_date, previous_purchase_date
    )), 1) AS avg_days_between_purchases,
    MIN(DATEDIFF(
        purchase_date, previous_purchase_date
    )) AS min_days_between_purchases,
    MAX(DATEDIFF(
        purchase_date, previous_purchase_date
    )) AS max_days_between_purchases
FROM customer_orders
WHERE purchase_number > 1;



-- ============================================================
-- QUERY 2: Repeat Purchase Gap Distribution
-- Purpose:
-- Classify repeat purchase events by the number of calendar
-- days between consecutive purchases and calculate percentages.
-- ============================================================

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        o.order_id,
        DATE(o.order_purchase_timestamp) AS purchase_date,

        ROW_NUMBER() OVER (
            PARTITION BY c.customer_unique_id
            ORDER BY o.order_purchase_timestamp, o.order_id
        ) AS purchase_number,

        LAG(DATE(o.order_purchase_timestamp)) OVER (
            PARTITION BY c.customer_unique_id
            ORDER BY o.order_purchase_timestamp, o.order_id
        ) AS previous_purchase_date

    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_purchase_timestamp IS NOT NULL
),
repeat_gaps AS (
    SELECT
        DATEDIFF(purchase_date, previous_purchase_date) AS gap_days
    FROM customer_orders
    WHERE purchase_number > 1
),
gap_bands AS (
    SELECT
        CASE
            WHEN gap_days = 0 THEN '0 days'
            WHEN gap_days BETWEEN 1 AND 30 THEN '1-30 days'
            WHEN gap_days BETWEEN 31 AND 60 THEN '31-60 days'
            WHEN gap_days BETWEEN 61 AND 90 THEN '61-90 days'
            WHEN gap_days BETWEEN 91 AND 180 THEN '91-180 days'
            ELSE '181+ days'
        END AS purchase_gap_band,

        CASE
            WHEN gap_days = 0 THEN 1
            WHEN gap_days BETWEEN 1 AND 30 THEN 2
            WHEN gap_days BETWEEN 31 AND 60 THEN 3
            WHEN gap_days BETWEEN 61 AND 90 THEN 4
            WHEN gap_days BETWEEN 91 AND 180 THEN 5
            ELSE 6
        END AS sort_order

    FROM repeat_gaps
)
SELECT
    purchase_gap_band,
    COUNT(*) AS repeat_purchase_events,

    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gap_bands),
        2
    ) AS event_percentage

FROM gap_bands
GROUP BY purchase_gap_band, sort_order
ORDER BY sort_order;
