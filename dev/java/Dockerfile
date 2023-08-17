# syntax=docker/dockerfile:1
# escape=\
# Rails requires node, so we base this off our node image.
FROM dev/000-base:local

RUN \
  sudo \
  apk add --no-cache \
    # Java Compiler
    openjdk11