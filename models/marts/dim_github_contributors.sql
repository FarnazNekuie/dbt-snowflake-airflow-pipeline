with commits as (
    select * from {{ ref('stg_github_commits') }}
)

select
    author_email as contributor_email,
    max(author_name) as contributor_name,

    count(distinct commit_sha) as total_commits,

    min(author_date) as first_commit_date,
    max(author_date) as latest_commit_date

from commits
where author_email is not null

group by
    author_email