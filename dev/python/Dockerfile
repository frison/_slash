# syntax=docker/dockerfile:1
# escape=\
FROM environment-dev-base:local-latest

# The base's software-properties-common package gets us most of the way
# there by providing python 3.9.9
RUN sudo apt-get install -y --no-install-recommends python3-pip
RUN sudo ln -s /bin/python3 /bin/python

COPY ./files /

RUN \
  sudo pip install -r /requirements.txt && \
  sudo pip install pytest
