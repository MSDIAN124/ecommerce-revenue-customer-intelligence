/*
===============================================================================
Project: E-Commerce Revenue & Customer Intelligence
File: 07_geographic_analysis.sql
Purpose: Analyze customer and seller geographic distribution, state-level
         delivered product sales, and same-state vs cross-state transactions.
Dataset: Brazilian E-Commerce Public Dataset by Olist
Database: ecommerce_analytics

Key Business Questions:
1. Which states have the largest customer base?
2. Which states generate the highest delivered product sales?
3. How are sellers distributed across states?
4. What proportion of delivered product sales is associated with same-state
   versus cross-state seller-customer transactions?

Metric Definitions:
- Customer counts use customer_unique_id for unique-customer analysis.
- Delivered product sales = SUM(order_items.price) for delivered orders.
- Freight value is reported separately from product sales.
- Same-state means customer_state = seller_state.
- Cross-state means customer_state differs from seller_state.

Important Limitations:
- Product sales are not profit or net recognized revenue.
- An order can contain items from multiple sellers and can appear in both
  same-state and cross-state groups.
- State-level results describe this dataset, not the entire Brazilian market.
- The raw geolocation table is intentionally not joined directly because
  ZIP prefixes can map to multiple coordinate records.

===============================================================================
*/

USE ecommerce_analytics;


-- ============================================================================
-- 1. Customer Geographic Distribution
-- Business question: Which states have the largest unique-customer base?
-- Grain: One result row per customer state.
-- ============================================================================

SELECT
    customer_state,
    COUNT(*) AS customer_records,
    COUNT(DISTINCT customer_unique_id) AS unique_customers,
    COUNT(DISTINCT customer_city) AS cities_covered
FROM customers
GROUP BY customer_state
ORDER BY unique_customers DESC;


-- ============================================================================
-- 2. State-Wise Order Volume and Delivered Product Sales
-- Business question: Which customer states contribute the highest delivered
-- product sales?
-- Grain: One result row per customer state.
-- Note: Freight is excluded from product sales and shown separately.
-- ============================================================================

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN o.order_status = 'delivered' THEN o.order_id
    END) AS delivered_orders,
    ROUND(SUM(CASE
        WHEN o.order_status = 'delivered' THEN oi.price
        ELSE 0
    END), 2) AS delivered_product_sales,
    ROUND(SUM(CASE
        WHEN o.order_status = 'delivered' THEN oi.freight_value
        ELSE 0
    END), 2) AS delivered_freight_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY delivered_product_sales DESC;


-- ============================================================================
-- 3. Seller Geographic Distribution
-- Business question: Which states have the largest seller presence?
-- Grain: One result row per seller state.
-- Note: City counts represent distinct city labels recorded in the dataset.
-- ============================================================================

SELECT
    seller_state,
    COUNT(*) AS seller_count,
    COUNT(DISTINCT seller_city) AS cities_covered
FROM sellers
GROUP BY seller_state
ORDER BY seller_count DESC;


-- ============================================================================
-- 4. Same-State vs Cross-State Delivered Transactions
-- Business question: How do product sales and freight values compare when
-- sellers are in the same state as customers versus a different state?
-- Grain: One result row per geography type.
-- Note: Counts are based on seller-order associations and are not additive
-- unique-order counts because an order may involve multiple sellers.
-- ============================================================================

SELECT
    CASE
        WHEN c.customer_state = s.seller_state
            THEN 'Same state'
        ELSE 'Cross state'
    END AS geography_type,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    COUNT(*) AS order_item_records,
    ROUND(SUM(oi.price), 2) AS product_sales,
    ROUND(SUM(oi.freight_value), 2) AS freight_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN sellers s
    ON oi.seller_id = s.seller_id
WHERE o.order_status = 'delivered'
GROUP BY geography_type
ORDER BY product_sales DESC;
