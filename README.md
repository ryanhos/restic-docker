# restic-util

# Purpose
Installing `restic` isn't hard, and pulling a docker image is easier.

# Usage
There are two ways to use this image.  One is flexible, but unhelpful.  The other is helpful but awkward.

## Batteries not included
The `restic` binary is the entrypoint, so any arguments that are valid for arguments to `docker run` after the image tag.
However, environment and volume setup (via docker flags) is up to the user as well.

```bash
docker run --hostname "${HOST}" --env-file auth.list \
  --volume "/home/user/dir-to-backup:/backup/symbolic-backup-set-name" "restic-util:0.9.5" \
  backup "/backup/symbolic-backup-set-name"
```

One of the consequences of using this image is that the backup paths in the repository are not the true paths on the 
host.  It's up to your backup automation to keep the mapping of symbolic names (`/backup/symbolic-backup-set-name`) 
to real paths ('/home/user/dir-to-backup').  If this is unacceptable, you're better off with the bare Restic binary.

## Batteries somewhat included, but awkward...
This image also contains images that can easily be installed on the local system to vastly simplify the backup and 
restore commands.  Install them into the current directory with this command: 
`docker run --entrypoint=/install-scripts-entrypoint restic-util:0.9.5 | tar -x`
Then uncomplicated backups get a lot easier:
```bash
./restic-util-backup.sh /home/user/dir-to-backup symbolic-backup-set-name
```
and to restore:
```bash
mkdir /tmp/restic-restore
./restic-util-restore.sh /tmp/restic-restore symbolic-backup-set-name
ls /tmp/restic-restore/backup/symbolic-backup-set-name
```
The restore wrapper script could be improved to avoid the awkward paths that result from the restore process, or 
ideally just restore directly to the real target path (`/home/user/dir-to-backup` in the backup example).  This will
probably change in the future without much warning...sorry.
