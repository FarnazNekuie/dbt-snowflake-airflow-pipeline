# dbt + Snowflake + Airflow Data Pipeline

End-to-end modern data pipeline project built using dbt, Snowflake, Airflow, and Cosmos.

## Project Overview

This project demonstrates a production-style analytics engineering workflow including:

- Data ingestion from Snowflake sample datasets
- Staging and transformation layers using dbt
- Fact and dimension modeling
- Incremental processing
- Data quality testing
- Historical snapshots
- Workflow orchestration with Airflow
- dbt lineage and documentation generation

## Tech Stack

- dbt Core
- Snowflake
- Apache Airflow
- Astronomer Cosmos
- SQL
- Python
- Docker
- Git & GitHub

## Project Structure

```text
models/
├── staging/
│   ├── stg_tpch_orders.sql
│   └── stg_tpch_line_items.sql
│
├── marts/
│   ├── fct_orders.sql
│   └── dim_customers.sql

snapshots/
└── orders_snapshot.sql

macros/
└── pricing.sql
