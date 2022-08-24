# syntax=docker/dockerfile:1
# escape=\
FROM ubuntu:22.04

RUN echo "2022-08-21 : I'm busting the cache because apt repositories changed enough to break a dependent image's apt-installs on new use of this" > /tmp/cache-buster

# Install all the tools we want in all of our dev environments
RUN \
  apt-get update && \
  apt-get upgrade -y && \
  DEBIAN_FRONTEND='noninteractive' \
  apt-get install -y --no-install-recommends \
  build-essential \
  ca-certificates \
  curl \
  dnsutils \
  git \
  inetutils-ping \
  jq \
  less \
  locales \
  man \
  netcat \
  openssh-client \
  postgresql-client \
  software-properties-common \
  sudo \
  tar \
  unzip \
  vim \
  wget \
  zsh

# Add the slash user with zsh shell and sudo + enable passwordless sudo
RUN \
  useradd --home-dir /home/human \
          --shell /usr/bin/zsh  \
          --create-home \
          --groups sudo \
          human \
  && echo "# Allow members of group sudo to execute any command without a password" >> /etc/sudoers \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Tools that aren't available in the package manager
RUN \
  wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 \
  && chmod +x /usr/local/bin/yq

# 11MB hurl.dev , a much better curl
RUN \
  wget -qO hurl_1.6.0_amd64.deb https://github.com/Orange-OpenSource/hurl/releases/download/1.6.0/hurl_1.6.0_amd64.deb \
  && dpkg -i hurl_1.6.0_amd64.deb \
  && rm hurl_1.6.0_amd64.deb

COPY ./files /
RUN \
  chmod +x /usr/local/bin/* && \
  chmod +x /entrypoint.sh

# Set home permissions and install oh-my-zsh 
RUN \
  export ZSH=/home/human/.oh-my-zsh && \
  export ZDOTDIR=/home/human && \
  /usr/local/ohmyzsh/tools/install.sh && \
  chown -R human:human /home/human

USER human
WORKDIR /home/human
ENV HOME /home/human
ENV PATH /usr/local/bin:$PATH

ENV HOSTNAME machine
ENTRYPOINT ["/entrypoint.sh"]
CMD ["zsh"]