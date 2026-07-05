from snowflake.snowpark import Session

connection_parameters = {
    "account": "<ACCOUNT>",
    "user": "<USERNAME>",
    "password": "<PASSWORD>",
    "role": "ACCOUNTADMIN",
    "warehouse": "SALES_WH",
    "database": "SALES_DW",
    "schema": "BRONZE"
}

session = Session.builder.configs(connection_parameters).create()