
USE ecommerce_analytics;

-- =========================================================
-- CUSTOMER INTELLIGENCE
-- Metric: Repeat-customer rate
-- Customer identity: customer_unique_id
-- Scope: All orders with a linked customer record
-- =========================================================

SELECT
    COUNT(*) AS total_unique_customers,
    SUM(CASE
        WHEN customer_order_count = 1 THEN 1
        ELSE 0
    END) AS one_time_customers,
    SUM(CASE
        WHEN customer_order_count > 1 THEN 1
        ELSE 0
    END) AS repeat_customers,
    ROUND(
        100.0 * SUM(CASE
            WHEN customer_order_count > 1 THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS repeat_customer_pct
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS customer_order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) AS customer_summary;



-- =========================================================
-- CUSTOMER ORDER FREQUENCY DISTRIBUTION
-- Counts customers by number of distinct orders
-- =========================================================

SELECT
    customer_order_count,
    COUNT(*) AS number_of_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS customer_order_count
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) AS customer_summary
GROUP BY customer_order_count
ORDER BY customer_order_count;
