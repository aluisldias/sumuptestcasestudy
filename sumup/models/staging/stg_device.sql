{{
    config(
        materialized='view'
    )
}}

SELECT
    -- Primary Key
    id AS device_id,

    -- Foreign Key to stores (assuming this links the device to a specific store)
    store_id,

    -- Descriptive Attributes
    type as device_type
    
    -- Other fields, if any, standardized here
    -- e.g., CAST(status AS VARCHAR) AS device_status

    -- Add a load timestamp/date if available in the raw data or ingestion process
    -- '{{ run_started_at }}'::TIMESTAMP_NTZ AS dbt_loaded_at

FROM {{ ref('device') }} 