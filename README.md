# dbt + Snowflake + Airflow Data Pipeline

End-to-end modern data pipeline project built using dbt, Snowflake, Airflow, and Astronomer Cosmos.

---

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

---

## Tech Stack

- dbt Core
- Snowflake
- Apache Airflow
- Astronomer Cosmos
- SQL
- Python
- Docker
- Git & GitHub

---

## Architecture Workflow

1. Source data is loaded from Snowflake sample datasets
2. dbt staging models clean and standardize raw data
3. Fact and dimension models transform business data
4. Incremental models optimize processing performance
5. dbt tests validate data quality
6. Snapshots track historical changes
7. Airflow orchestrates and schedules the pipeline
8. dbt docs generate lineage and model documentation

---

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
│
snapshots/
└── orders_snapshot.sql
│
macros/
└── pricing.sql
```

---

## Screenshots

### Airflow DAG Orchestration
![Airflow DAG](screenshots/airflow_dag_success.png)

### dbt Lineage Graph
![dbt Lineage](screenshots/dbt_lineage_graph.png)

### Snowflake Fact Table
![Snowflake Fact Table](screenshots/snowflake_fact_table.png)

### Snowflake Staging View
![Snowflake Staging View](screenshots/snowflake_staging_view.png)

---

## Key Features

- Modular dbt transformations
- Incremental model materialization
- Reusable SQL macros
- Automated orchestration with Airflow
- Data quality testing with dbt tests
- Historical tracking using snapshots
- End-to-end ELT workflow
- Automated lineage documentation
