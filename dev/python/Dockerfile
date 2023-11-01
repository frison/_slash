# syntax=docker/dockerfile:1
# escape=\
FROM dev/001-base:local

RUN sudo \
  apk add \
    python3-dev py3-pip \
    linux-headers gcc g++ musl-dev

COPY ./files /

ENV PATH $HOME/.local/bin:$PATH

RUN \
  pip install -r /requirements.txt && \
  pip install pytest
