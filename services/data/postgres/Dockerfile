# syntax=docker/dockerfile:1
# escape=\
FROM postgres

COPY ./files /
RUN chmod +x /*entrypoint*.sh
RUN chmod +x /docker-entrypoint-initdb.d/*.sh
ENTRYPOINT [ "/pre-entrypoint.sh" ]
CMD ["postgres"]