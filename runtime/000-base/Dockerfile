# syntax=docker/dockerfile:1
# escape=\
FROM ubuntu:22.04

RUN \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    git \
    python3 python3-pip