--Question 5

with ranking_transactions as (

    select
        store_id,
        happened_at_utc,
        -- Assign a sequential rank to each transaction within a store based on its time
        ROW_NUMBER() over(partition by store_id order by happened_at_utc) as transaction_rank
    from
        {{ ref('int_transaction') }}
),
first_five_transactions as (
    -- 2. Filter for the first 5 transactions and find the time of the 1st and 5th
    select
        store_id,
        happened_at_utc,
        transaction_rank,
        -- Get the timestamp of the very first transaction (rank 1) for the store
        max(case when transaction_rank = 1 then happened_at_utc end) over(partition by store_id) as first_transaction_time,
        -- Get the timestamp of the fifth transaction (rank 5) for the store
        max(case when transaction_rank = 5 then happened_at_utc end) over(partition by store_id) as fifth_transaction_time
    from
        ranking_transactions
    where
        transaction_rank <= 5
)

select
    store_id,
    -- Calculate the duration between the 5th and 1st transaction in seconds 
    extract(epoch from (fifth_transaction_time - first_transaction_time))/86400 as time_for_5_transactions_days
from
    first_five_transactions
where
    transaction_rank = 5 
group by
    store_id,
    time_for_5_transactions_days
order by
    store_id