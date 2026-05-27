{% snapshot orders_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='order_key',
      strategy='check',
      check_cols=['status_code', 'total_price']
    )
}}

select
    order_key,
    customer_key,
    status_code,
    total_price,
    order_date
from {{ ref('stg_tpch_orders') }}

{% endsnapshot %}