# syntax=docker/dockerfile:1
# escape=\
ARG BASE_VERSION="6.10"
FROM dpage/pgadmin4:${BASE_VERSION}

ENV PGADMIN_DEFAULT_EMAIL="user@domain.tld"
ENV PGADMIN_DEFAULT_PASSWORD="password"
ENV PGADMIN_CONFIG_SERVER_MODE="False"
ENV PGADMIN_CONFIG_MASTER_PASSWORD_REQUIRED="False"

ENV POSTGRES_HOST="postgres"
ENV POSTGRES_PORT="5432"
ENV POSTGRES_DB="*"

USER root
COPY ./files /
RUN chmod +x /pre-entrypoint.sh && \
    touch /pgadmin4/servers.json && \
    chown pgadmin:root /pgadmin4/servers.json

USER pgadmin
ENTRYPOINT /pre-entrypoint.sh