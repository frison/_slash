# syntax=docker/dockerfile:1
# escape=\
FROM alpine:3.16

# When there are upstream dependency changes that would not result
# in a rebuild of the image, we can explain why we need a rebuild here
# and force subsequent layers to rebuild.
RUN echo "2022-10-04 : aint no cache busting yet" > /tmp/cache-buster

RUN apk add --no-cache \
    ca-certificates \
    git \
    curl wget \
    openssh-client \
    zsh \
    sudo

# Create a group and user
RUN addgroup -S human \
    && adduser -S human -G human -G wheel -s zsh -h /home/human -D \
    # All members of wheel group to sudo without password
    && echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

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

RUN apk add --no-cache \
    yq jq \
    vim

USER human
WORKDIR /home/human
ENV HOME /home/human
ENV PATH /usr/local/bin:$PATH

ENV HOSTNAME machine
ENTRYPOINT ["/entrypoint.sh"]
CMD ["zsh"]