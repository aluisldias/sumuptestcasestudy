
    
    

with all_values as (

    select
        status as value_field,
        count(*) as n_records

    from "postgres"."analytics_staging"."stg_transaction"
    group by status

)

select *
from all_values
where value_field not in (
    'accepted','refused','cancelled'
)


