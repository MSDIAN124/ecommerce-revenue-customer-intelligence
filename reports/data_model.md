# Data Model and Table Grain

## Project
E-Commerce Revenue & Customer Intelligence

## 1. Table Grain and Key Strategy

| Dataset | Table grain — one row represents | Key strategy |
|---|---|---|
| olist_customers_dataset | One customer-location record | `customer_id` |
| olist_orders_dataset | One order | `order_id` |
| olist_order_items_dataset | One item line within an order | Composite key: `order_id` + `order_item_id` |
| olist_order_payments_dataset | One payment entry for an order | Composite key: `order_id` + `payment_sequential` |
| olist_order_reviews_dataset | One review record | `review_id` alone is not a safe unique key |
| olist_products_dataset | One product | `product_id` |
| olist_sellers_dataset | One seller | `seller_id` |
| olist_geolocation_dataset | One raw ZIP-prefix coordinate record | No reliable unique key established |
| product_category_name_translation | One product-category translation | `product_category_name` |

## 2. Important Relationships

- Orders → Customers: `customer_id`
- Order Items → Orders: `order_id`
- Order Items → Products: `product_id`
- Order Items → Sellers: `seller_id`
- Payments → Orders: `order_id`
- Reviews → Orders: `order_id`
- Products → Category Translation: `product_category_name`

## 3. Data Modeling Decisions

1. Use `customer_unique_id` for customer-level repeat-purchase analysis, rather than treating every `customer_id` as a distinct person.
2. Preserve multiple payment entries for an order.
3. Preserve multiple item lines within an order.
4. Do not assume `review_id` is unique. Retain review records and investigate repeated IDs before defining a cleaned-table key.
5. Do not join the raw geolocation table directly to business tables. Multiple coordinate records can exist for one ZIP prefix, potentially multiplying rows and inflating totals.
6. Keep raw data unchanged. Apply documented transformations in staging or processed tables.
7. Distinguish recorded item value, freight charges, payment amounts, and order status. Do not automatically treat them as interchangeable revenue measures.

## 4. Dataset Scope and Limitations

The dataset represents Brazilian e-commerce activity, primarily from September 2016 through October 2018. It is not Indian-market data.

The available fields do not establish actual business profit, and missing review comments do not necessarily indicate invalid reviews. All analytical conclusions must reflect these limitations.
