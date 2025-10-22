--Question 1) 

SELECT
    store_name,
    --SUM(amount_eur) AS total_amount
    amount_eur
FROM
    {{ ref('int_transaction') }} 
WHERE status = 'accepted' and store_id = 3



--GROUP BY

--    store_name
--ORDER BY
--    total_amount DESC
--limit 10 