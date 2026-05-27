select distinct
    order_date,

    extract(year from order_date) as order_year,
    extract(month from order_date) as order_month,
    extract(day from order_date) as order_day,
    dayname(order_date) as day_name

from {{ ref('stg_tpch_orders') }}