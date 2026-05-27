with repositories as (
    select * from {{ ref('stg_github_repositories') }}
),

commit_activity as (
    select
        repository_id,
        count(distinct commit_sha) as total_commits,
        min(author_date)           as first_commit_date,
        max(author_date)           as latest_commit_date
    from {{ ref('stg_github_commits') }}
    group by repository_id
),

workflow_activity as (
    select
        repository_id,
        count(*) as total_workflow_runs
    from {{ ref('stg_github_workflow_runs') }}
    group by repository_id
)

select
    repositories.repository_id,
    repositories.repository_name,
    repositories.full_name              as repository_full_name,
    repositories.description,
    repositories.language,
    repositories.default_branch,
    repositories.homepage,
    repositories.is_fork,
    repositories.is_archived,
    repositories.is_private,
    repositories.owner_id,
    repositories.watchers_count,
    repositories.forks_count,
    repositories.created_at             as repository_created_at,

    coalesce(commit_activity.total_commits, 0)         as total_commits,
    commit_activity.first_commit_date,
    commit_activity.latest_commit_date,
    coalesce(workflow_activity.total_workflow_runs, 0) as total_workflow_runs

from repositories
left join commit_activity
    on repositories.repository_id = commit_activity.repository_id
left join workflow_activity
    on repositories.repository_id = workflow_activity.repository_id
