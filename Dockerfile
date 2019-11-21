FROM debian:stable

RUN apt-get update
RUN apt-get install -y --no-install-recommends ca-certificates fuse

RUN mkdir /backup /restore /scripts

COPY restic /usr/local/bin/
COPY *.sh /scripts/
COPY install-scripts-entrypoint /

ENTRYPOINT ["/usr/local/bin/restic"]
