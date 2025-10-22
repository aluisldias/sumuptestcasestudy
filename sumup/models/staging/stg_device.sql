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
    


FROM {{ ref('device') }} 