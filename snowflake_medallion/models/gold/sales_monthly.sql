{{ config(
    materialized='table'
) }}

SELECT

    ORDER_YEAR,

    ORDER_MONTH,

    COUNT(*) AS TOTAL_ORDERS,

    ROUND(SUM(NET_AMOUNT),2) AS TOTAL_REVENUE,

    SUM(QUANTITY) AS TOTAL_QUANTITY

FROM {{ ref('silver_sales') }}

GROUP BY
    ORDER_YEAR,
    ORDER_MONTH

ORDER BY
    ORDER_YEAR,
    ORDER_MONTH