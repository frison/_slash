#!/usr/bin/env sh

# set -x
set -e

export POSTGRES_HOST=${DEFAULT_DB_HOST:-${POSTGRES_HOST:-localhost}}
export POSTGRES_PORT=${DEFAULT_DB_PORT:-${POSTGRES_PORT:-5432}}
export POSTGRES_DB=${DEFAULT_DB_NAME:-${POSTGRES_DB:-postgres}}
export POSTGRES_USER=${DEFAULT_DB_USER:-${POSTGRES_USER:-postgres}}
export POSTGRES_PASSWORD=${DEFAULT_DB_PASSWORD:-${POSTGRES_PASSWORD:-postgres}}

# Desktop mode, so no login is needed. Email is required
export PGADMIN_DEFAULT_EMAIL=${DEFAULT_EMAIL:-${PGADMIN_DEFAULT_EMAIL:-"user@domain.tld"}}
export PGADMIN_DEFAULT_PASSWORD=${DEFAULT_DB_PASSWORD:-${PGADMIN_DEFAULT_PASSWORD:-"password"}}
export PGADMIN_CONFIG_SERVER_MODE="False"
export PGADMIN_CONFIG_MASTER_PASSWORD_REQUIRED="False"

## Create /var/lib/pgadmin/pgpass which provides the credentials referenced in the servers.json below
echo -n "$POSTGRES_HOST:$POSTGRES_PORT:$POSTGRES_DB:$POSTGRES_USER:$POSTGRES_PASSWORD" | tee /var/lib/pgadmin/pgpass >/dev/null

chmod 600 /var/lib/pgadmin/pgpass
chown pgadmin:root /var/lib/pgadmin/pgpass

## Create servers.json which sets up the connection between pgadmin and our postgres server
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