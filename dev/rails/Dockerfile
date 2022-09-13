# syntax=docker/dockerfile:1
# escape=\
# Rails requires node, so we base this off our node image.
FROM dev-node:local

RUN \
  sudo \
  apk add \
    # Rails build packages
    curl-dev ruby-dev build-base bash \
    # Rails gems
    libpq-dev

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
  && gem install rails -v 7.0.3

RUN \
   curl https://cli-assets.heroku.com/install.sh | sh

COPY ./files /
RUN cd / && bundle install
