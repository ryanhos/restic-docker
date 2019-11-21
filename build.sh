#!/usr/bin/env bash

set -uexo pipefail

release_semver="${1:-0.9.5}"
arch="${2:-linux_amd64}"
restic_bz2="restic_${release_semver}_${arch}.bz2"
github_release_tar_gz="https://github.com/restic/restic/releases/download/v${release_semver}/${restic_bz2}"

this_repo_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
dokerfile="${this_repo_dir}/Dockerfile"
workdir="${this_repo_dir}/work"
restic_binary="${workdir}/restic"
final_docker_tag="restic-util:${release_semver}"

trap '{ rm -rf "${workdir}"; }' EXIT

mkdir -p  "${workdir}"
cd "${workdir}"

docker pull debian:stable

curl -L "${github_release_tar_gz}" -O
bzip2 -d "${restic_bz2}" > "${restic_binary}"
chmod u+x "${restic_binary}"

docker build --file "${dokerfile}" -t "${final_docker_tag}" "${workdir}"
