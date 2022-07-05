#!/usr/bin/env sh

export POSTGRES_PASSWORD=${DEFAULT_DB_PASSWORD:-${POSTGRES_PASSWORD:-postgres}}

exec docker-entrypoint.sh "$@"