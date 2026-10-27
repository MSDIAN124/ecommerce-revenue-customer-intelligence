
USE ecommerce_analytics;

-- ============================================================
-- Project: E-Commerce Revenue & Customer Intelligence
-- File: 10_data_quality_validation.sql
-- Purpose: Validate key relationships between order items,
--          products, and sellers.
-- Dataset: Olist Brazilian E-Commerce Public Dataset
-- ============================================================


-- 1. ORDER ITEM PRODUCT AND SELLER RELATIONSHIP VALIDATION
-- Business Question:
-- Do all product and seller IDs referenced in order_items
-- match records in the respective master tables?
--
-- Expected interpretation:
-- Zero unmatched IDs indicate that all references checked
-- have a corresponding product or seller record.

SELECT
    COUNT(*) AS total_order_items,

    SUM(
        CASE
            WHEN p.product_id IS NULL THEN 1
            ELSE 0
        END
    ) AS unmatched_product_ids,

    SUM(
        CASE
            WHEN s.seller_id IS NULL THEN 1
            ELSE 0
        END
    ) AS unmatched_seller_ids

FROM order_items oi

LEFT JOIN products p
    ON oi.product_id = p.product_id

LEFT JOIN sellers s
    ON oi.seller_id = s.seller_id;
