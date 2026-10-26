/*
===============================================================================
Project: E-Commerce Revenue & Customer Intelligence
File: 08_customer_purchasing_behavior.sql
Purpose: Analyze order payment values, delivered-order average payment value,
         customer spending, and spending distributions.
Dataset: Brazilian E-Commerce Public Dataset by Olist
Database: ecommerce_analytics

Key Business Questions:
1. What is the average recorded payment value per order?
2. How are orders distributed across payment-value bands?
3. Are zero-value orders associated with canceled orders?
4. What is the average recorded payment value for delivered orders?
5. What is the total recorded spending per unique customer?
6. How are customers distributed across spending bands?

Methodology:
- Aggregate payment records to order level before calculating order metrics.
- Use customer_unique_id for unique-customer analysis.
- Keep payment-based order value separate from item-price-based sales.
- Preserve zero-value and canceled-order records in the source data.
- Spending bands are descriptive analytical categories.

Limitations:
- Recorded payment value is not profit or net recognized revenue.
- Customer spending metrics include recorded payments across order statuses.
- Orders without payment records are excluded from payment-based metrics.
- The dataset represents historical Olist activity, not the current market.

===============================================================================
*/

USE ecommerce_analytics;

-- =========================================================
-- DAY 6: CUSTOMER PURCHASING BEHAVIOR
-- Analysis 1: Average Order Value (AOV)
-- Grain: One row per order before aggregation
-- Scope: Orders with recorded payment records
-- Metric: Total recorded payment value per order
-- Note: This is payment-based order value, not profit.
-- =========================================================

SELECT
    COUNT(*) AS orders_with_payments,
    ROUND(AVG(order_payment_total), 2) AS average_order_value,
    ROUND(MIN(order_payment_total), 2) AS minimum_order_value,
    ROUND(MAX(order_payment_total), 2) AS maximum_order_value,
    ROUND(SUM(order_payment_total), 2) AS total_recorded_payment_value
FROM (
    SELECT
        o.order_id,
        SUM(p.payment_value) AS order_payment_total
    FROM orders o
    JOIN order_payments p
        ON o.order_id = p.order_id
    GROUP BY o.order_id
) AS order_totals;


-- =========================================================
-- DAY 6: CUSTOMER PURCHASING BEHAVIOR
-- Analysis 2: Order Value Distribution
-- Grain: One row per order, then grouped into value bands
-- Scope: Orders with recorded payment records
-- Note: Bands are analytical categories, not official
-- business thresholds.
-- =========================================================

SELECT
    CASE
        WHEN order_payment_total = 0 THEN '0 - Zero'
        WHEN order_payment_total > 0
             AND order_payment_total < 50 THEN '1 - Under 50'
        WHEN order_payment_total >= 50
             AND order_payment_total < 100 THEN '2 - 50 to 99.99'
        WHEN order_payment_total >= 100
             AND order_payment_total < 250 THEN '3 - 100 to 249.99'
        WHEN order_payment_total >= 250
             AND order_payment_total < 500 THEN '4 - 250 to 499.99'
        ELSE '5 - 500 and above'
    END AS order_value_band,
    COUNT(*) AS number_of_orders,
    ROUND(
        100.0 * COUNT(*) / (SELECT COUNT(DISTINCT order_id)
                            FROM order_payments),
        2
    ) AS pct_of_orders
FROM (
    SELECT
        order_id,
        SUM(payment_value) AS order_payment_total
    FROM order_payments
    GROUP BY order_id
) AS order_totals
GROUP BY order_value_band
ORDER BY order_value_band;

-- =========================================================
-- DAY 6: CUSTOMER PURCHASING BEHAVIOR
-- Analysis 3: Zero-Value Order Investigation
-- Purpose: Inspect orders whose recorded payment total is 0.
-- =========================================================

SELECT
    p.order_id,
    COUNT(*) AS payment_records,
    ROUND(SUM(p.payment_value), 2) AS total_payment_value,
    GROUP_CONCAT(
        DISTINCT p.payment_type
        ORDER BY p.payment_type
        SEPARATOR ', '
    ) AS payment_types,
    GROUP_CONCAT(
        DISTINCT o.order_status
        ORDER BY o.order_status
        SEPARATOR ', '
    ) AS order_statuses
FROM order_payments p
JOIN orders o
    ON p.order_id = o.order_id
GROUP BY p.order_id
HAVING SUM(p.payment_value) = 0
ORDER BY p.order_id;

-- =========================================================
-- DAY 6: CUSTOMER PURCHASING BEHAVIOR
-- Analysis 4: Delivered-Order Average Payment Value
-- Scope: Delivered orders with recorded payment records.
-- Metric: Average total recorded payment per delivered order.
-- Note: Payment value is not profit or net revenue.
-- =========================================================

SELECT
    COUNT(*) AS delivered_orders_with_payments,
    ROUND(AVG(order_payment_total), 2) AS average_payment_per_delivered_order,
    ROUND(MIN(order_payment_total), 2) AS minimum_payment,
    ROUND(MAX(order_payment_total), 2) AS maximum_payment,
    ROUND(SUM(order_payment_total), 2) AS total_delivered_order_payments
FROM (
    SELECT
        o.order_id,
        SUM(p.payment_value) AS order_payment_total
    FROM orders o
    JOIN order_payments p
        ON o.order_id = p.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY o.order_id
) AS delivered_order_totals;


-- =========================================================
-- DAY 6: CUSTOMER PURCHASING BEHAVIOR
-- Analysis 5: Customer Spending Distribution
-- Grain: One row per unique customer before aggregation
-- Scope: Customers with linked orders and payment records
-- Note: Includes recorded payments across order statuses.
-- =========================================================

SELECT
    COUNT(*) AS customers_with_payments,
    ROUND(AVG(customer_total_spend), 2) AS average_customer_spend,
    ROUND(MIN(customer_total_spend), 2) AS minimum_customer_spend,
    ROUND(MAX(customer_total_spend), 2) AS maximum_customer_spend,
    ROUND(AVG(customer_order_count), 2) AS average_orders_per_customer
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS customer_order_count,
        SUM(p.payment_value) AS customer_total_spend
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_payments p
        ON o.order_id = p.order_id
    GROUP BY c.customer_unique_id
) AS customer_summary;


-- =========================================================
-- DAY 6: CUSTOMER PURCHASING BEHAVIOR
-- Analysis 6: Customer Spending Distribution
-- Grain: One row per unique customer
-- Scope: Customers with linked orders and payment records
-- Note: Spending bands are descriptive categories.
-- =========================================================

SELECT
    CASE
        WHEN customer_total_spend = 0 THEN '0 - Zero'
        WHEN customer_total_spend > 0
             AND customer_total_spend < 100 THEN '1 - Under 100'
        WHEN customer_total_spend >= 100
             AND customer_total_spend < 250 THEN '2 - 100 to 249.99'
        WHEN customer_total_spend >= 250
             AND customer_total_spend < 500 THEN '3 - 250 to 499.99'
        ELSE '4 - 500 and above'
    END AS customer_spending_band,
    COUNT(*) AS number_of_customers,
    ROUND(
        100.0 * COUNT(*) / (SELECT COUNT(*)
                            FROM (
                                SELECT c.customer_unique_id
                                FROM customers c
                                JOIN orders o
                                    ON c.customer_id = o.customer_id
                                JOIN order_payments p
                                    ON o.order_id = p.order_id
                                GROUP BY c.customer_unique_id
                            ) AS all_customers),
        2
    ) AS pct_of_customers
FROM (
    SELECT
        c.customer_unique_id,
        SUM(p.payment_value) AS customer_total_spend
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_payments p
        ON o.order_id = p.order_id
    GROUP BY c.customer_unique_id
) AS customer_summary
GROUP BY customer_spending_band
ORDER BY customer_spending_band;
