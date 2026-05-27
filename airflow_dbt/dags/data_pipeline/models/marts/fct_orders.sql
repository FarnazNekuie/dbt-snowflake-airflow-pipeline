{{ config(materialized='incremental') }}

with orders as (
    select * from {{ ref('stg_tpch_orders') }}
),

line_items as (
    select * from {{ ref('stg_tpch_line_items') }}
),

order_items_summary as (
    select
        order_key,
        sum(extended_price) as gross_item_sales_amount,
        sum(extended_price * (1 - discount_percentage)) as net_item_sales_amount,
        sum({{ discounted_amount('extended_price', 'discount_percentage') }}) as item_discount_amount
    from line_items
    group by order_key
)

select
    orders.order_key,
    orders.customer_key,
    orders.status_code,
    orders.total_price,
    orders.order_date,
    order_items_summary.gross_item_sales_amount,
    order_items_summary.net_item_sales_amount,
    order_items_summary.item_discount_amount
from orders
left join order_items_summary
    on orders.order_key = order_items_summary.order_key

{% if is_incremental() %}
where orders.order_date > (
    select max(order_date)
    from {{ this }}
)
{% endif %}