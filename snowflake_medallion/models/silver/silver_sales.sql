{{ config(
    materialized = 'incremental',
    unique_key = 'ORDER_ID'
) }}

WITH latest_orders AS (

    SELECT
        ORDER_ID,
        ORDER_DATE,
        CUSTOMER_ID,
        CUSTOMER_CITY,
        PRODUCT_CATEGORY,
        QUANTITY,
        UNIT_PRICE,
        DISCOUNT_PCT,
        PAYMENT_METHOD,
        ORDER_STATUS,
        SOURCE_FILE_NAME,
        INGESTION_TIMESTAMP,

        ROW_NUMBER() OVER (
            PARTITION BY ORDER_ID
            ORDER BY INGESTION_TIMESTAMP DESC
        ) AS RN

    FROM {{ ref('stg_sales') }}

    {% if is_incremental() %}

        WHERE INGESTION_TIMESTAMP >
        (
            SELECT COALESCE(MAX(LAST_UPDATED_TIMESTAMP), '1900-01-01')
            FROM {{ this }}
        )

    {% endif %}

)

SELECT

    ORDER_ID,
    ORDER_DATE,
    CUSTOMER_ID,
    CUSTOMER_CITY,
    PRODUCT_CATEGORY,

    QUANTITY,
    UNIT_PRICE,
    DISCOUNT_PCT,

    (QUANTITY * UNIT_PRICE * (1 - DISCOUNT_PCT)) AS NET_AMOUNT,

    PAYMENT_METHOD,
    ORDER_STATUS,

    YEAR(ORDER_DATE)  AS ORDER_YEAR,
    MONTH(ORDER_DATE) AS ORDER_MONTH,

    SOURCE_FILE_NAME,

    INGESTION_TIMESTAMP AS LAST_UPDATED_TIMESTAMP

FROM latest_orders

WHERE RN = 1