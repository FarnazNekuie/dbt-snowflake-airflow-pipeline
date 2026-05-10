with workflow_runs as (
    select * from {{ ref('stg_github_workflow_runs') }}
),

repositories as (
    select * from {{ ref('stg_github_repositories') }}
)

select
    workflow_runs.workflow_run_id,
    workflow_runs.workflow_id,
    workflow_runs.workflow_name,
    workflow_runs.repository_id,
    repositories.repository_name,
    repositories.full_name as repository_full_name,
    workflow_runs.head_branch,
    workflow_runs.head_sha,
    workflow_runs.run_number,
    workflow_runs.run_attempt,
    workflow_runs.event,
    workflow_runs.status,
    workflow_runs.conclusion,
    workflow_runs.created_at,
    workflow_runs.updated_at,
    workflow_runs.run_started_at,

    datediff(
        'second',
        workflow_runs.run_started_at,
        workflow_runs.updated_at
    ) as workflow_duration_seconds,

    case
        when workflow_runs.conclusion = 'success' then 1
        else 0
    end as is_successful,

    case
        when workflow_runs.conclusion = 'failure' then 1
        else 0
    end as is_failed

from workflow_runs
left join repositories
    on workflow_runs.repository_id = repositories.repository_id