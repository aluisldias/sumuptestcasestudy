
    
    

select
    id as unique_field,
    count(*) as n_records

from "postgres"."analytics_staging"."stg_transaction"
where id is not null
group by id
having count(*) > 1


