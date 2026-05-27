select
    repository_name,
    count(distinct commit_sha) as total_commits,
    count(distinct author_email) as total_contributors,
    min(commit_date) as first_commit_date,
    max(commit_date) as latest_commit_date
from {{ ref('fct_github_commits') }}
group by repository_name