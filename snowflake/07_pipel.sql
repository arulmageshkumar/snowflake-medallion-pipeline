/*
=========================================================
File      : 07_pipe.sql
Project   : Snowflake Medallion Pipeline
Purpose   : Create Snowpipe for automatic ingestion
Author    : Arul
=========================================================
*/

USE WAREHOUSE SALES_WH;
USE DATABASE SALES_DW;
USE SCHEMA BRONZE;

CREATE OR REPLACE PIPE SALES_PIPE
AUTO_INGEST = TRUE
AS
COPY INTO RAW_SALES
(
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
    SOURCE_FILE_NAME
)
FROM
(
    SELECT
        $1  AS ORDER_ID,
        $2  AS ORDER_DATE,
        $3  AS CUSTOMER_ID,
        $4  AS CUSTOMER_CITY,
        $5  AS PRODUCT_CATEGORY,
        $6  AS QUANTITY,
        $7  AS UNIT_PRICE,
        $8  AS DISCOUNT_PCT,
        $9  AS PAYMENT_METHOD,
        $10 AS ORDER_STATUS,
        METADATA$FILENAME AS SOURCE_FILE_NAME
    FROM @SALES_STAGE
)
FILE_FORMAT = (
    FORMAT_NAME = 'CSV_FORMAT'
);