SELECT
    -- Primary Key: Rename to be explicit
    id AS store_id,
    name AS store_name,

    -- Descriptive Attributes: Rename 'typology' for clarity
    typology AS store_typology,
    country,
    city
    
FROM {{ ref('store') }}