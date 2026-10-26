
-- ============================================================
-- Project: E-Commerce Revenue & Customer Intelligence
-- ============================================================
-- Day 4: Seller Performance Analysis
-- File: 06_seller_performance_analysis.sql
-- Purpose: Analyze seller order volume, product sales,
--          delivery timeliness, and associated review ratings.
-- Dataset: Olist Brazilian E-Commerce Public Dataset
-- ============================================================

USE ecommerce_analytics;

-- ------------------------------------------------------------
-- 1. SELLER DATA BASELINE
-- Purpose:
-- Validate seller coverage, order-item volume, distinct orders,
-- and seller-order combinations.
-- Note:
-- Orders may contain items from multiple sellers.
-- ------------------------------------------------------------


SELECT
    (SELECT COUNT(*)
     FROM sellers) AS total_sellers,

    COUNT(DISTINCT oi.seller_id) AS sellers_with_order_items,

    COUNT(*) AS total_order_item_records,

    COUNT(DISTINCT oi.order_id) AS distinct_orders,

    COUNT(DISTINCT oi.seller_id, oi.order_id)
        AS seller_order_combinations

FROM order_items oi;

-- ------------------------------------------------------------
-- 2. SELLER-WISE ORDER VOLUME AND PRODUCT SALES
-- Purpose:
-- Rank sellers by delivered order volume, item count,
-- product sales value, and freight value.
-- Note:
-- Product sales are not profit or net recognized revenue.
-- ------------------------------------------------------------


SELECT
    oi.seller_id,
    COUNT(DISTINCT oi.order_id) AS delivered_orders,
    COUNT(*) AS delivered_order_items,
    ROUND(SUM(oi.price), 2) AS product_sales_value,
    ROUND(SUM(oi.freight_value), 2) AS freight_value
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id
ORDER BY product_sales_value DESC
LIMIT 10;

-- ------------------------------------------------------------
-- 3. SELLER-WISE DELIVERY PERFORMANCE
-- Purpose:
-- Compare eligible delivered orders and late-delivery rates.
-- Minimum sample: 50 eligible delivered orders per seller.
-- Note:
-- Seller-level order counts may overlap across sellers.
-- Results are descriptive, not causal.
-- ------------------------------------------------------------

SELECT
    oi.seller_id,
    COUNT(DISTINCT oi.order_id) AS eligible_orders,

    COUNT(DISTINCT CASE
        WHEN o.order_delivered_customer_date
             <= o.order_estimated_delivery_date
        THEN oi.order_id
    END) AS on_time_orders,

    COUNT(DISTINCT CASE
        WHEN o.order_delivered_customer_date
             > o.order_estimated_delivery_date
        THEN oi.order_id
    END) AS late_orders,

    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN o.order_delivered_customer_date
                 > o.order_estimated_delivery_date
            THEN oi.order_id
        END) / COUNT(DISTINCT oi.order_id),
        2
    ) AS late_delivery_pct

FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL

GROUP BY oi.seller_id

HAVING COUNT(DISTINCT oi.order_id) >= 50

ORDER BY late_delivery_pct DESC, eligible_orders DESC
LIMIT 10;

-- ------------------------------------------------------------
-- 4. SELLER-ASSOCIATED REVIEW RATINGS
-- Purpose:
-- Compare average review scores and low-rating percentages
-- for sellers with at least 50 distinct reviewed orders.
-- Definition:
-- Low rating = review score of 1 or 2.
-- Note:
-- Reviews are order-level and may be associated with multiple
-- sellers in a multi-seller order.
-- Multiple review records are preserved in the analysis.
-- ------------------------------------------------------------


SELECT
    oi.seller_id,
    COUNT(DISTINCT oi.order_id) AS reviewed_orders,
    COUNT(DISTINCT r.order_id) AS orders_with_reviews,
    ROUND(AVG(r.order_avg_review_score), 2) AS avg_review_score,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN r.order_avg_review_score <= 2 THEN 1
                ELSE 0
            END
        ) / COUNT(DISTINCT r.order_id),
        2
    ) AS low_rating_pct

FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN (
    SELECT
        order_id,
        AVG(review_score) AS order_avg_review_score
    FROM order_reviews
    GROUP BY order_id
) r
    ON o.order_id = r.order_id

WHERE o.order_status = 'delivered'

GROUP BY oi.seller_id

HAVING COUNT(DISTINCT r.order_id) >= 50

ORDER BY avg_review_score ASC, orders_with_reviews DESC
LIMIT 10;