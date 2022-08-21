# syntax=docker/dockerfile:1
# escape=\
FROM dev-base:local

RUN \
  DEBIAN_FRONTEND='noninteractive' \
  sudo -E apt-get install -y --no-install-recommends \
  git-core \
  zlib1g-dev \
  build-essential \
  libssl-dev \
  zlib1g-dev \
  libreadline-dev \
  libyaml-dev \
  libsqlite3-dev \
  libpq-dev \
  libpq5 \
  sqlite3 \
  libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  software-properties-common \
  libffi-dev \
  nodejs \
  yarn

RUN \
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
  && echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc \
  && ~/.rbenv/bin/rbenv init - >> ~/.zshrc \
  && git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

ENV PATH="$HOME/.rbenv/shims:$HOME/.rbenv/plugins/ruby-build/bin:$HOME/.rbenv/bin:$PATH"
RUN \
  rbenv install 3.1.2 \
  && rbenv global 3.1.2

RUN \
  gem install bundler \
  && rbenv rehash \
  && gem install rails -v 7.0.3 \
  && rbenv rehash

RUN \
   curl https://cli-assets.heroku.com/install.sh | sh

COPY ./files /
RUN cd / && bundle install
