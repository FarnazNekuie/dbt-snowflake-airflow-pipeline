select distinct
    status_code,

    case
        when status_code = 'O' then 'Open'
        when status_code = 'F' then 'Fulfilled'
        when status_code = 'P' then 'Pending'
        else 'Unknown'
    end as status_description

from {{ ref('stg_tpch_orders') }}