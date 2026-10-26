
USE ecommerce_analytics;

-- ============================================================
-- Project: E-Commerce Revenue & Customer Intelligence
-- File: 02_product_category_analysis.sql
-- Purpose: PRODUCT CATEGORY PERFORMANCE
-- Scope: Delivered orders only
-- Sales metric: Sum of item prices, excluding freight
-- Dataset: Olist Brazilian E-Commerce Public Dataset
-- ============================================================


SELECT
    COALESCE(
        ct.product_category_name_english,
        'Unknown / Unmapped'
    ) AS product_category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(*) AS order_items,
    ROUND(SUM(oi.price), 2) AS product_sales_value,
    ROUND(SUM(oi.freight_value), 2) AS freight_value
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY COALESCE(
    ct.product_category_name_english,
    'Unknown / Unmapped'
)
ORDER BY product_sales_value DESC
LIMIT 10;
