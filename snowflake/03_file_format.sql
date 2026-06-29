/*
=========================================================
File      : 03_file_format.sql
Project   : Snowflake Medallion Pipeline
Purpose   : Create reusable CSV file format for Snowpipe
Author    : Arul
=========================================================
*/

USE WAREHOUSE SALES_WH;
USE DATABASE SALES_DW;

CREATE OR REPLACE FILE FORMAT CSV_FORMAT
TYPE = CSV
COMPRESSION = AUTO
FIELD_DELIMITER = ','
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
TRIM_SPACE = TRUE
EMPTY_FIELD_AS_NULL = TRUE
NULL_IF = ('NULL', 'null', '')
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE;