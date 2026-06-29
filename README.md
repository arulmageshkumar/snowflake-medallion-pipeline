# Snowflake Medallion Pipeline

## Overview

An end-to-end data engineering project demonstrating automated data ingestion and transformation using Amazon S3, Snowpipe, Snowpark, and dbt following the Medallion Architecture.

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
- ✅ Load data into Bronze layer
- ⏳ Snowpark data cleansing
- ⏳ Silver layer (dbt)
- ⏳ Gold layer (dbt)