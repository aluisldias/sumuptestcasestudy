--Question 2) 

select product_name,
    count(*) as total_sales
from {{ ref('int_transaction') }}
group by product_name
order by total_sales desc 
--limit 10