select
    sha as commit_sha,
    repository_id,
    author_email,
    author_name,
    author_date,
    committer_email,
    committer_name,
    committer_date,
    message as commit_message,
    _fivetran_synced
from {{ source('github', 'COMMIT') }}