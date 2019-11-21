FROM debian:stable

RUN apt-get update
RUN apt-get install -y --no-install-recommends ca-certificates fuse

RUN mkdir /backup /restore

COPY restic /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/restic"]
