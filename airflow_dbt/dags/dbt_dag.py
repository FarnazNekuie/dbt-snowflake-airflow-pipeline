"""
Airflow DAG that orchestrates the end-to-end dbt pipeline on Snowflake
using Astronomer Cosmos.

Task flow:
    source_freshness  ─►  source_tests  ─►  dbt_models  ─►  generate_docs

- source_freshness runs `dbt source freshness` to catch stale Fivetran data
  before downstream models burn compute.
- source_tests runs `dbt test --select source:*` to validate raw inputs.
- dbt_models is the Cosmos task group that expands into one Airflow task per
  dbt model and per dbt test, mirroring the dbt lineage graph.
- generate_docs builds the dbt docs catalog so the lineage UI stays current.
"""

from datetime import datetime

from airflow import DAG
from airflow.operators.empty import EmptyOperator

from cosmos import DbtTaskGroup, ProjectConfig, ProfileConfig, RenderConfig
from cosmos.constants import TestBehavior
from cosmos.operators.local import (
    DbtSourceLocalOperator,
    DbtTestLocalOperator,
    DbtDocsLocalOperator,
)
from cosmos.profiles import SnowflakeUserPasswordProfileMapping

DBT_PROJECT_PATH = "/usr/local/airflow/dags/data_pipeline"

profile_config = ProfileConfig(
    profile_name="data_pipeline",
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="snowflake_conn",
        profile_args={
            "database": "DBT_DB",
            "schema": "DBT_SCHEMA",
            "warehouse": "DBT_WAREHOUSE",
            "role": "ACCOUNTADMIN",
        },
    ),
)

common_operator_args = {
    "project_dir": DBT_PROJECT_PATH,
    "profile_config": profile_config,
    "install_deps": True,
}

with DAG(
    dag_id="dbt_snowflake_pipeline",
    start_date=datetime(2026, 5, 9),
    schedule="@daily",
    catchup=False,
    tags=["dbt", "snowflake", "cosmos", "fivetran", "github"],
    doc_md=__doc__,
) as dag:

    start = EmptyOperator(task_id="start")

    source_freshness = DbtSourceLocalOperator(
        task_id="source_freshness",
        **common_operator_args,
    )

    source_tests = DbtTestLocalOperator(
        task_id="source_tests",
        select=["source:*"],
        **common_operator_args,
    )

    dbt_models = DbtTaskGroup(
        group_id="dbt_models",
        project_config=ProjectConfig(DBT_PROJECT_PATH),
        profile_config=profile_config,
        render_config=RenderConfig(test_behavior=TestBehavior.AFTER_EACH),
    )

    generate_docs = DbtDocsLocalOperator(
        task_id="generate_docs",
        **common_operator_args,
    )

    end = EmptyOperator(task_id="end")

    start >> source_freshness >> source_tests >> dbt_models >> generate_docs >> end
