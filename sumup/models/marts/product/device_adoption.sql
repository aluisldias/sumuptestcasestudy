select
    device_type,
    count(transaction_id) as transaction_count,
    -- Calculate the percentage: (Count for this device / Total overall count) * 100
    (cast(count(transaction_id) as numeric) * 100.0) / sum(count(transaction_id)) over () as percentage_of_total
from {{ ref('int_transaction') }}
group by 1 -- Group by device_type
order by 3 desc -- Order by percentage