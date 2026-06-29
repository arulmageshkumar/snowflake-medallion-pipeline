/*
=========================================================
File      : 06_bronze_table.sql
Project   : Snowflake Medallion Pipeline
Purpose   : Create Bronze layer table
Author    : Arul
=========================================================
*/

USE WAREHOUSE SALES_WH;
USE DATABASE SALES_DW;
USE SCHEMA BRONZE;

CREATE OR REPLACE TABLE RAW_SALES
(
    ORDER_ID              STRING,
    ORDER_DATE            DATE,
    CUSTOMER_ID           STRING,
    CUSTOMER_CITY         STRING,
    PRODUCT_CATEGORY      STRING,
    QUANTITY              NUMBER(10,0),
    UNIT_PRICE            NUMBER(10,2),
    DISCOUNT_PCT          NUMBER(5,2),
    PAYMENT_METHOD        STRING,
    ORDER_STATUS          STRING,

    SOURCE_FILE_NAME      STRING,
    INGESTION_TIMESTAMP   TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);