# syntax=docker/dockerfile:1
# escape=\
FROM dev-base:local

RUN \
  DEBIAN_FRONTEND='noninteractive' \
  sudo -E apt-get install -y --no-install-recommends \
  whois

COPY ./files /

RUN \
  sudo chown -R human:human /home/human