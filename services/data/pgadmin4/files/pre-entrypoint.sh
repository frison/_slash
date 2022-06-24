#!/usr/bin/env sh

# set -x
set -e

export PGADMIN_DEFAULT_EMAIL="user@domain.tld"
export PGADMIN_DEFAULT_PASSWORD="password"
export PGADMIN_CONFIG_SERVER_MODE="False"
export PGADMIN_CONFIG_MASTER_PASSWORD_REQUIRED="False"

export POSTGRES_HOST=${DEFAULT_DB_HOST:-${POSTGRES_HOST:-localhost}}
export POSTGRES_PORT=${DEFAULT_DB_PORT:-${POSTGRES_PORT:-5432}}
export POSTGRES_DB=${DEFAULT_DB_NAME:-${POSTGRES_DB:-postgres}}
export POSTGRES_USER=${DEFAULT_USER:-${POSTGRES_USER:-postgres}}
export POSTGRES_PASSWORD=${DEFAULT_PASSWORD:-${POSTGRES_PASSWORD:-postgres}}

## Create /var/lib/pgadmin/pgpass
echo "$POSTGRES_HOST:$POSTGRES_PORT:$POSTGRES_DB:$POSTGRES_USER:$POSTGRES_PASSWORD" | tee /var/lib/pgadmin/pgpass >/dev/null

chmod 600 /var/lib/pgadmin/pgpass
chown pgadmin:root /var/lib/pgadmin/pgpass

## Create servers.json
tee /pgadmin4/servers.json >/dev/null <<EOF
{
    "Servers": {
        "1": {
            "Name": "$POSTGRES_HOST",
            "Group": "Servers",
            "Host": "$POSTGRES_HOST",
            "Port": $POSTGRES_PORT,
            "MaintenanceDB": "$POSTGRES_DB",
            "Username": "$POSTGRES_USER",
            "SSLMode": "prefer",
            "PassFile": "/var/lib/pgadmin/pgpass"
        }
    }
}
EOF
chown pgadmin:root /pgadmin4/servers.json

exec /entrypoint.sh "$@"