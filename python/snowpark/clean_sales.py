
from snowflake.snowpark.functions import (
    col,
    upper,
    trim,
    when
)

# ----------------------------------------------------
# Snowflake Connection
# ----------------------------------------------------

from config import session

# ----------------------------------------------------
# Read Bronze Raw Table
# ----------------------------------------------------

df = session.table("RAW_SALES")

# ----------------------------------------------------
# Data Cleansing
# ----------------------------------------------------

df = (
    df

    # Remove leading/trailing spaces
    .with_column(
        "PRODUCT_CATEGORY",
        trim(col("PRODUCT_CATEGORY"))
    )

    .with_column(
        "PAYMENT_METHOD",
        trim(col("PAYMENT_METHOD"))
    )

    # Replace NULL city and Standardize City
   .with_column(
        "CUSTOMER_CITY",
        when(
          col("CUSTOMER_CITY").is_null(),
          "UNKNOWN"
           ).otherwise(
            upper(trim(col("CUSTOMER_CITY")))
        )
    )

    # Standardize Payment Method
    .with_column(
        "PAYMENT_METHOD",
        upper(col("PAYMENT_METHOD"))
    )
)

# ----------------------------------------------------
# Save Clean Data
# ----------------------------------------------------

df.write.mode("overwrite").save_as_table("CLEAN_SALES")

print("Data successfully cleaned and loaded into CLEAN_SALES")

session.close()