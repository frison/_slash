#!/bin/bash
#
# Why does this file start with 500-?
# 
# Initialization scripts are called in sorted order.
# For example
# 
# 000-Q.sh, 000-QA.sh would get executed in...
# Confusing, right? 000-QA or 000-Q first?
# 
# So name them 000-Q.sh and 001-QA.sh so the order is 
# clearly defined. Don't be afraid to leave room in case
# additions are needed to be added between scripts.
#
#
# That is, consider:
# 100-Q.sh, 200-QA.sh, leaving plenty of room to sneak
# things inbetween.
#
# #### Actual Example 
#
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
#	CREATE USER docker;
#	CREATE DATABASE docker;
#	GRANT ALL PRIVILEGES ON DATABASE docker TO docker;
# EOSQL

echo "I'm the README script I am"
echo "Remember, if you want to rebuild these scripts you must"
echo "............. DELETE THE VOLUME"