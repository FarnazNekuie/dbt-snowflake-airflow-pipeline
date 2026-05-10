# dbt + Snowflake + Airflow Modern Data Platform

End-to-end modern ELT and analytics engineering project built using dbt, Snowflake, Airflow, Fivetran, Astronomer Cosmos, and GitHub Actions.

---

## Project Overview

This project demonstrates a production-style cloud analytics engineering workflow including:

- Automated ELT ingestion using Fivetran
- Cloud data warehousing with Snowflake
- Staging and transformation layers using dbt
- Fact and dimension modeling
- Incremental data processing
- Source freshness monitoring
- Data quality testing
- Historical snapshots
- Workflow orchestration with Airflow + Cosmos
- CI/CD validation using GitHub Actions
- GitHub operational analytics and KPI modeling
- dbt lineage and warehouse documentation

---

## Tech Stack

- dbt Core / dbt Fusion
- Snowflake
- Apache Airflow
- Astronomer Cosmos
- Fivetran
- GitHub Actions
- SQL
- Python
- Docker
- Git & GitHub

---

## Architecture Workflow

```text
GitHub
   ↓
Fivetran
   ↓
Snowflake
   ↓
dbt Staging Models
   ↓
Fact & Dimension Models
   ↓
Analytics KPI Marts
   ↓
Airflow Orchestration + CI/CD
```

---

## Project Structure

```text
models/
├── staging/
│   ├── github/
│   │   ├── stg_github_repositories.sql
│   │   ├── stg_github_commits.sql
│   │   └── stg_github_workflow_runs.sql
│   │
│   ├── stg_tpch_orders.sql
│   └── stg_tpch_line_items.sql
│
├── marts/
│   ├── fct_orders.sql
│   ├── dim_customers.sql
│   ├── dim_order_status.sql
│   ├── dim_order_dates.sql
│   ├── fct_github_workflow_runs.sql
│   ├── fct_github_commits.sql
│   ├── dim_github_contributors.sql
│   ├── github_workflow_kpis.sql
│   ├── github_commit_kpis.sql
│   └── github_contributor_kpis.sql
│
snapshots/
└── orders_snapshot.sql
│
macros/
└── pricing.sql
```

---

## Key Features

- Modern ELT pipeline architecture
- Automated GitHub ingestion with Fivetran
- Modular dbt transformations
- Incremental model materialization
- Reusable SQL macros
- Airflow DAG orchestration
- Data quality testing with dbt
- Source freshness monitoring
- Historical tracking using snapshots
- GitHub Actions CI/CD validation
- Contributor analytics and workflow monitoring
- End-to-end cloud analytics engineering workflow
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


