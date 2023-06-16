# syntax=docker/dockerfile:1
# escape=\
FROM postgres

COPY ./files /

# These can go away once the filemodes in the repo are fixed
RUN chmod +x /*entrypoint*.sh && \
    chmod +x /docker-entrypoint-initdb.d/*.sh && \
    chmod +x /usr/bin/connect.sh

ENTRYPOINT [ "/pre-entrypoint.sh" ]
CMD ["postgres"]