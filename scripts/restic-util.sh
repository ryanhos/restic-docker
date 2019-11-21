restic_version=${restic_version:-0.9.5}
auth_vars_file=${auth_vars_file:-auth.list}

docker run --hostname "${HOST}" --env-file "${auth_vars_file}" "restic-util:${restic_version}" $@
