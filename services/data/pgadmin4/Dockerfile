# syntax=docker/dockerfile:1
# escape=\
ARG BASE_VERSION="6.10"
FROM dpage/pgadmin4:${BASE_VERSION}

USER root
COPY ./files /
RUN chmod +x /pre-entrypoint.sh && \
    touch /pgadmin4/servers.json && \
    chown pgadmin:root /pgadmin4/servers.json

USER pgadmin
ENTRYPOINT /pre-entrypoint.sh