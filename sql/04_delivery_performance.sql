
-- ============================================================
-- Project: E-Commerce Revenue & Customer Intelligence
-- File: 04_delivery_performance.sql
-- Purpose: Analyze delivery timeliness, delay duration,
--          and month-wise delivery performance.
-- Dataset: Olist Brazilian E-Commerce Public Dataset
-- ============================================================

USE ecommerce_analytics;

-- ------------------------------------------------------------
-- 1. DELIVERY DATE COMPLETENESS CHECK
-- Purpose:
-- Check delivered orders for availability of actual and
-- estimated delivery dates.
-- Note:
-- Only orders with both dates can be classified as on-time
-- or late for this analysis.
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS delivered_orders,
    SUM(CASE
        WHEN order_delivered_customer_date IS NOT NULL THEN 1
        ELSE 0
    END) AS orders_with_actual_delivery,
    SUM(CASE
        WHEN order_estimated_delivery_date IS NOT NULL THEN 1
        ELSE 0
    END) AS orders_with_estimated_delivery,
    SUM(CASE
        WHEN order_delivered_customer_date IS NOT NULL
         AND order_estimated_delivery_date IS NOT NULL
        THEN 1 ELSE 0
    END) AS orders_with_both_dates
FROM orders
WHERE order_status = 'delivered';

-- ------------------------------------------------------------
-- 2. OVERALL ON-TIME VS. LATE DELIVERY PERFORMANCE
-- Purpose:
-- Calculate the number and percentage of on-time and late
-- deliveries among delivered orders with both dates available.
-- Definition:
-- On-time = Actual delivery timestamp <= Estimated timestamp
-- Late    = Actual delivery timestamp > Estimated timestamp
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS orders_evaluated,

    SUM(CASE
        WHEN order_delivered_customer_date
             <= order_estimated_delivery_date
        THEN 1 ELSE 0
    END) AS on_time_orders,

    SUM(CASE
        WHEN order_delivered_customer_date
             > order_estimated_delivery_date
        THEN 1 ELSE 0
    END) AS late_orders,

    ROUND(
        100.0 * SUM(CASE
            WHEN order_delivered_customer_date
                 <= order_estimated_delivery_date
            THEN 1 ELSE 0
        END) / COUNT(*), 2
    ) AS on_time_delivery_pct,

    ROUND(
        100.0 * SUM(CASE
            WHEN order_delivered_customer_date
                 > order_estimated_delivery_date
            THEN 1 ELSE 0
        END) / COUNT(*), 2
    ) AS late_delivery_pct

FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;


-- ------------------------------------------------------------
-- 3. DELIVERY DELAY DURATION
-- Purpose:
-- Measure minimum, average, and maximum delay among late orders.
-- Note:
-- TIMESTAMPDIFF(DAY, ...) counts complete 24-hour periods;
-- a positive delay shorter than 24 hours may return 0 days.
-- ------------------------------------------------------------

WITH late_delivery AS (
    SELECT
        TIMESTAMPDIFF(
            DAY,
            order_estimated_delivery_date,
            order_delivered_customer_date
        ) AS delay_days
    FROM orders
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
      AND order_delivered_customer_date >
          order_estimated_delivery_date
)
SELECT
    COUNT(*) AS late_orders,
    ROUND(AVG(delay_days), 2) AS avg_delay_days,
    MAX(delay_days) AS max_delay_days,
    MIN(delay_days) AS min_delay_days
FROM late_delivery;



-- ------------------------------------------------------------
-- 4. MONTH-WISE DELIVERY PERFORMANCE
-- Purpose:
-- Compare delivered order volume and late-delivery percentage
-- by the month in which each order was purchased.
-- Note:
-- Purchase month is not the same as delivery month.
-- Partial months and differences in order volume should be
-- considered when interpreting monthly percentages.
-- ------------------------------------------------------------

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS purchase_month,
    COUNT(*) AS delivered_orders,
    SUM(CASE
        WHEN order_delivered_customer_date
             > order_estimated_delivery_date
        THEN 1 ELSE 0
    END) AS late_orders,
    ROUND(
        100.0 * SUM(CASE
            WHEN order_delivered_customer_date
                 > order_estimated_delivery_date
            THEN 1 ELSE 0
        END) / COUNT(*),
        2
    ) AS late_delivery_pct
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY purchase_month;