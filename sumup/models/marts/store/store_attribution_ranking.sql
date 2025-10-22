--Question 3
select store_typology,
        country,
        avg(amount_eur) as average_amount_eur
from {{ ref('int_transaction') }}
group by 1,2 
where status = 'accepted'
