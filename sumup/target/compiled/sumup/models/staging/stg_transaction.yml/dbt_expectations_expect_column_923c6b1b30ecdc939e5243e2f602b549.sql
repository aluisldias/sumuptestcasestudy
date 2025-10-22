





    with grouped_expression as (
    select
        
        
    
  
( 1=1 and length(
        card_number
    ) >= 13 and length(
        card_number
    ) <= 25
)
 as expression


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






