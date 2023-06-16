# syntax=docker/dockerfile:1
# escape=\
FROM frison/scratch:scripts AS scripts
FROM runtime/000-base:local

COPY ./artifacts /
RUN pip install -r /requirements.txt

COPY ./files /
COPY --from=scripts / /
ENTRYPOINT ["/entrypoint.sh"]