select
    repository_name,
    count(*) as total_workflow_runs,
    sum(is_successful) as successful_runs,
    sum(is_failed) as failed_runs,

    round(
        sum(is_successful) / nullif(count(*), 0) * 100,
        2
    ) as success_rate_percent,

    avg(workflow_duration_seconds) as avg_duration_seconds,
    max(updated_at) as latest_run_at

from {{ ref('fct_github_workflow_runs') }}

group by repository_name