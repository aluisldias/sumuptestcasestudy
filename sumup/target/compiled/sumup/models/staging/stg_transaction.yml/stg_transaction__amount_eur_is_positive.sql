

    
    with grouped_expression as (
    select
        
        
    
  amount_eur > 0 as expression


    from "postgres"."analytics_staging"."stg_transaction"
    

),
validation_errors as (

    select
        *
    from
        grouped_expression
    where
        not(expression = true)

)

select *
from validation_errors




