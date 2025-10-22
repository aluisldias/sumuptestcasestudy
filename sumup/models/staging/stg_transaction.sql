SELECT
    -- Primary and Foreign Keys
    CAST(id AS INTEGER) AS transaction_id,
    CAST(device_id AS INTEGER) AS device_id,

    -- Product Information
   
    MD5(CONCAT(TRIM(LOWER(product_name)), '|' ,TRIM(LOWER(product_sku)))::BYTEA ) AS product_id,
    product_name,
    product_sku, 
    category_name,

    -- Financial Data & Status
    -- Convert amount from cents (as typically stored for high precision) to Euros (€)
    CAST(amount AS NUMERIC) AS amount_eur,
    LOWER(status) AS status,

    -- Card Information 
    REPLACE(REPLACE(CAST(card_number AS VARCHAR), ' ', ''), '-', '') AS card_number,
    CAST(cvv AS VARCHAR) AS cvv,
    
    -- Date/Time Fields
    -- The original columns contained mixed date formats, ensuring they are cast to timestamps
    CAST(created_at AS TIMESTAMP) AS created_at_utc,
    CAST(happened_at AS TIMESTAMP) AS happened_at_utc

FROM {{ ref('transaction') }}