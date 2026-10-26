
-- ============================================================
-- Project: E-Commerce Revenue & Customer Intelligence
-- File: 05_customer_experience_analysis.sql
-- Purpose: Analyze customer review ratings and their association
--          with delivery timeliness.
-- Dataset: Olist Brazilian E-Commerce Public Dataset
-- ============================================================

USE ecommerce_analytics;

-- ------------------------------------------------------------
-- 1. REVIEW DATA BASELINE
-- Purpose:
-- Summarize review records, distinct orders reviewed,
-- average review score, 1-star and 5-star counts,
-- and records without written comments.
-- Note:
-- A missing comment does not mean the rating is invalid.
-- ------------------------------------------------------------


SELECT
    COUNT(*) AS total_review_records,
    COUNT(DISTINCT order_id) AS distinct_orders_reviewed,
    ROUND(AVG(review_score), 2) AS average_review_score,

    SUM(CASE
        WHEN review_score = 1 THEN 1 ELSE 0
    END) AS one_star_reviews,

    SUM(CASE
        WHEN review_score = 5 THEN 1 ELSE 0
    END) AS five_star_reviews,

    SUM(CASE
        WHEN review_comment_message IS NULL
          OR TRIM(review_comment_message) = ''
        THEN 1 ELSE 0
    END) AS reviews_without_comments

FROM order_reviews;

-- ------------------------------------------------------------
-- 2. REVIEW SCORE DISTRIBUTION
-- Purpose:
-- Calculate the count and percentage of reviews for each
-- rating from 1 to 5 stars.
-- Note:
-- Percentages use total review records as the denominator.
-- ------------------------------------------------------------


SELECT
    review_score,
    COUNT(*) AS review_count,
    ROUND(
        100.0 * COUNT(*) / (SELECT COUNT(*) FROM order_reviews),
        2
    ) AS review_pct
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;

-- ------------------------------------------------------------
-- 3. REVIEW RATINGS BY DELIVERY TIMELINESS
-- Purpose:
-- Compare average review scores and low-rating percentages
-- across on-time, late, and unavailable-date groups.
-- Definition:
-- Low rating = review score of 1 or 2.
-- Note:
-- This is an association analysis, not proof of causation.
-- Multiple review records per order are preserved.
-- Orders without usable delivery dates require separate
-- interpretation and may include incomplete orders.
-- ------------------------------------------------------------


SELECT
    CASE
        WHEN o.order_delivered_customer_date IS NULL
            OR o.order_estimated_delivery_date IS NULL
            THEN 'Delivery dates unavailable'
        WHEN o.order_delivered_customer_date
             > o.order_estimated_delivery_date
            THEN 'Late delivery'
        ELSE 'On-time delivery'
    END AS delivery_group,

    COUNT(*) AS review_records,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,

    ROUND(
        100.0 * SUM(
            CASE WHEN r.review_score <= 2 THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS low_rating_pct

FROM order_reviews r
JOIN orders o
    ON r.order_id = o.order_id

GROUP BY delivery_group
ORDER BY delivery_group;