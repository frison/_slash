# syntax=docker/dockerfile:1
# escape=\
FROM dev-base:local

RUN sudo \
  apk add \
    nmap whois

COPY --chown=human:human ./files /
