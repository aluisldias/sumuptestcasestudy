{{
    config(
        materialized='view'
    )
}}

SELECT
    -- Primary Key: Rename to be explicit
    id AS store_id,
    name AS store_name,

    -- Descriptive Attributes: Rename 'typology' for clarity
    typology AS store_typology,
    country,
    city
    
    -- Add a load timestamp/date if available in the raw data or ingestion process
    -- '{{ run_started_at }}'::TIMESTAMP_NTZ AS dbt_loaded_at

FROM {{ ref('store') }}