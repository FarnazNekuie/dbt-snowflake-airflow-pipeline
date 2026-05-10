select
    id as workflow_run_id,
    name as workflow_name,
    head_branch,
    head_sha,
    repository_id,
    run_number,
    event,
    status,
    conclusion,
    workflow_id,
    created_at,
    updated_at,
    run_attempt,
    run_started_at,
    triggering_actor_id,
    actor_id,
    _fivetran_synced
from {{ source('github', 'WORKFLOW_RUN') }}