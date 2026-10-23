
USE ecommerce_analytics;

-- =========================================================
-- E-COMMERCE REVENUE AND ORDER ANALYSIS
-- Dataset: Olist Brazilian E-Commerce Public Dataset
-- Purpose: Explore order trends and reconcile payment values
-- =========================================================


-- 1. DATASET DATE RANGE AND ORDER COUNT

SELECT
    COUNT(*) AS total_orders,
    MIN(order_purchase_timestamp) AS first_purchase,
    MAX(order_purchase_timestamp) AS last_purchase
FROM orders;


-- 2. MONTHLY ORDER TRENDS

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_status = 'delivered' THEN 1 ELSE 0 END)
        AS delivered_orders,
    SUM(CASE WHEN order_status = 'canceled' THEN 1 ELSE 0 END)
        AS canceled_orders
FROM orders
WHERE order_purchase_timestamp IS NOT NULL
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;


-- 3. MONTHLY RECORDED PAYMENT VALUE
-- Note: Includes all order statuses; not recognized revenue.

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.order_id) AS orders_with_payments,
    ROUND(SUM(p.payment_value), 2) AS recorded_payment_value,
    ROUND(AVG(p.payment_value), 2) AS avg_payment_record_value
FROM orders o
JOIN order_payments p
    ON o.order_id = p.order_id
WHERE o.order_purchase_timestamp IS NOT NULL
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;


-- 4. RECORDED PAYMENT VALUE BY ORDER STATUS

SELECT
    o.order_status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT p.order_id) AS orders_with_payments,
    ROUND(SUM(p.payment_value), 2) AS recorded_payment_value
FROM orders o
LEFT JOIN order_payments p
    ON o.order_id = p.order_id
GROUP BY o.order_status
ORDER BY recorded_payment_value DESC;


-- 5. DELIVERED ORDERS WITHOUT PAYMENT RECORDS

SELECT
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp
FROM orders o
LEFT JOIN order_payments p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
  AND p.order_id IS NULL;


-- 6. ORDER-LEVEL PAYMENT RECONCILIATION

SELECT
    COUNT(*) AS total_orders_with_payments,
    SUM(CASE WHEN payment_record_count = 1 THEN 1 ELSE 0 END)
        AS orders_with_one_payment_record,
    SUM(CASE WHEN payment_record_count > 1 THEN 1 ELSE 0 END)
        AS orders_with_multiple_payment_records,
    ROUND(AVG(order_payment_total), 2) AS avg_payment_per_order
FROM (
    SELECT
        order_id,
        COUNT(*) AS payment_record_count,
        SUM(payment_value) AS order_payment_total
    FROM order_payments
    GROUP BY order_id
) AS payment_summary;
