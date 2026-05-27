select
    id as repository_id,
    name as repository_name,
    full_name,
    description,
    fork as is_fork,
    archived as is_archived,
    homepage,
    language,
    default_branch,
    created_at,
    watchers_count,
    forks_count,
    owner_id,
    private as is_private,
    _fivetran_synced
from {{ source('github', 'REPOSITORY') }}