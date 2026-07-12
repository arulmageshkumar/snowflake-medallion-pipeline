# Snowflake Medallion Pipeline

## Overview

This project demonstrates an end-to-end data engineering pipeline built on Snowflake using the Medallion Architecture.

A fictional e-commerce application generates a daily sales file containing both new orders and updates to existing orders. The file is uploaded to Amazon S3, where Snowpipe automatically ingests the data into the Bronze layer.

Snowpark standardizes the incoming data without applying business rules. A dbt incremental model then merges new and updated records into the Silver layer, while the Gold layer provides aggregated reporting and analytics.

## Architecture

Python Faker
    ↓
Amazon S3
    ↓
Snowpipe Auto Ingestion
    ↓
Bronze
    ↓
Snowpark
    ↓
Silver (dbt)
    ↓
Gold (dbt)

## Tech Stack

- Snowflake
- Snowpipe
- Snowpark (Python)
- dbt Core
- Amazon S3
- Python (Faker, Pandas)

## Current Progress

- ✅ Generate sample sales data
- ✅ Upload files to Amazon S3
- ✅ Configure Storage Integration
- ✅ Create External Stage
- ✅ Configure Snowpipe
- ✅ Load data into Bronze layer (`RAW_SALES`)
- ✅ Standardize data using Snowpark (`CLEAN_SALES`)
- ✅ dbt source() configuration
- ✅ dbt staging model
- ✅ dbt incremental Silver model (MERGE)
- ⏳ Gold analytics models
- ⏳ dbt tests
- ⏳ Documentation & lineage