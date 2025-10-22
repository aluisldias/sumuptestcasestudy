

SELECT
    -- Primary and Foreign Keys
    transaction_id,
    t.device_id,

    -- Product Information
   
    CONCAT(TRIM(LOWER(product_name)), '|' ,TRIM(LOWER(product_sku)))::BYTEA  AS product_id,
    product_name,
    product_sku, 
    category_name,

    -- Financial Data and Status
    amount_eur,
    status,

    --device data
    d.device_type,
    
    -- store_data
    d.store_id,
    store_name,
    store_typology,

    -- Card Information 
    MD5( REPLACE(REPLACE(CAST(card_number AS VARCHAR), ' ', ''), '-', '')) AS card_number_hashed,
    MD5( CAST(cvv AS VARCHAR)) AS cvv_hashed,
    
    -- Date/Time Fields
    created_at_utc,
    happened_at_utc

FROM "postgres"."analytics_staging"."stg_transaction" t
LEFT JOIN "postgres"."analytics_staging"."stg_device" d ON t.device_id = d.device_id
LEFT JOIN "postgres"."analytics_staging"."stg_store" s ON d.store_id = s.store_id

-- Incremental Logic: Only select new records for subsequent runs

    WHERE t.created_at_utc > (SELECT MAX(created_at_utc) FROM "postgres"."analytics_analytics"."int_transaction")
