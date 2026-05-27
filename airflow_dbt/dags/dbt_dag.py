from datetime import datetime
from airflow import DAG

from cosmos import DbtTaskGroup, ProjectConfig, ProfileConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping

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

with DAG(
    dag_id="dbt_snowflake_pipeline",
    start_date=datetime(2026, 5, 9),
    schedule="@daily",
    catchup=False,
) as dag:

    dbt_tasks = DbtTaskGroup(
        group_id="dbt_models",
        project_config=ProjectConfig(
            "/usr/local/airflow/dags/data_pipeline"
        ),
        profile_config=profile_config,
    )