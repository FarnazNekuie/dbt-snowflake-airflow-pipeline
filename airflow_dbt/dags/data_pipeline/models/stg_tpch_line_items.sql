select
    l_orderkey as order_key,
    l_partkey as part_key,
    l_suppkey as supplier_key,
    l_linenumber as line_number,
    l_quantity as quantity,
    l_extendedprice as extended_price,
    l_discount as discount_percentage,
    l_tax as tax_rate,
    l_returnflag as return_flag,
    l_linestatus as line_status,
    l_shipdate as ship_date
from {{ source('tpch', 'LINEITEM') }}