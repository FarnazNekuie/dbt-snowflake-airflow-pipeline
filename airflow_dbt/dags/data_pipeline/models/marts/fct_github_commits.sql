{{
    config(
        materialized='incremental',
        unique_key='commit_sha',
        incremental_strategy='merge',
        on_schema_change='append_new_columns'
    )
}}

with commits as (
    select * from {{ ref('stg_github_commits') }}

    {% if is_incremental() %}
        where _fivetran_synced > (select coalesce(max(_fivetran_synced), '1900-01-01') from {{ this }})
    {% endif %}
),

repositories as (
    select * from {{ ref('stg_github_repositories') }}
)

select
    commits.commit_sha,
    commits.repository_id,
    repositories.repository_name,
    repositories.full_name as repository_full_name,
    commits.author_name,
    commits.author_email,
    commits.author_date,
    commits.committer_name,
    commits.committer_email,
    commits.committer_date,
    commits.commit_message,
    date_trunc('day', commits.author_date) as commit_date,
    date_trunc('week', commits.author_date) as commit_week,
    date_trunc('month', commits.author_date) as commit_month,
    commits._fivetran_synced
from commits
left join repositories
    on commits.repository_id = repositories.repository_id