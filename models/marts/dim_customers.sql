with orders as (
    select * from {{ ref('stg_tpch_orders') }}
)

select
    customer_key,
    count(order_key) as total_orders,
    min(order_date) as first_order_date,
    max(order_date) as most_recent_order_date,
    sum(total_price) as total_order_amount
from orders
group by customer_key