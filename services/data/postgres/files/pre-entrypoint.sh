#!/usr/bin/env sh

# set -x
set -e

# See https://hub.docker.com/_/postgres 
export POSTGRES_HOST=${DEFAULT_DB_HOST:-${POSTGRES_HOST}}
export POSTGRES_PORT=${DEFAULT_DB_PORT:-${POSTGRES_PORT:-5432}}

export POSTGRES_USER=${DEFAULT_DB_USER:-${POSTGRES_USER:-postgres}}
export POSTGRES_DB=${DEFAULT_DB_NAME:-${POSTGRES_USER}}

export POSTGRES_PASSWORD=${DEFAULT_PASSWORD:-${POSTGRES_PASSWORD:-postgres}}

exec docker-entrypoint.sh "$@"