select
    contributor_name,
    contributor_email,
    total_commits,
    first_commit_date,
    latest_commit_date
from {{ ref('dim_github_contributors') }}
order by total_commits desc