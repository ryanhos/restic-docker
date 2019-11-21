
backup_path=$1
backup_set_name=$2
shift 2
restic_version=${restic_version:-0.9.5}
auth_vars_file=${auth_vars_file:-auth.list}

docker run --hostname "${HOST}" --env-file "${auth_vars_file}" \
  --volume "${backup_path}:/backup/${backup_set_name}" "restic-util:${restic_version}" \
  backup "/backup/${backup_set_name}" $@
