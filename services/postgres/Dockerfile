# syntax=docker/dockerfile:1
# escape=\
FROM postgres

COPY ./files /
RUN chmod +x /*entrypoint*.sh && \
    chmod +x /docker-entrypoint-initdb.d/*.sh && \
    chmod +x /bin/connect.sh
ENTRYPOINT [ "/pre-entrypoint.sh" ]
CMD ["postgres"]