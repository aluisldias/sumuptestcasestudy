

SELECT
    -- Primary Key: Rename to be explicit
    id AS store_id,
    name AS store_name,

    -- Descriptive Attributes: Rename 'typology' for clarity
    typology AS store_typology,
    country,
    city
    
    -- Add a load timestamp/date if available in the raw data or ingestion process
    -- '2025-10-22 06:56:32.798668+00:00'::TIMESTAMP_NTZ AS dbt_loaded_at

FROM "postgres"."analytics"."store"