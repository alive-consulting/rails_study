

# Web
FROM ruby:3.2.2

# イメージ実行時に起動させる主プロセスを設定
CMD ["rails", "server", "-b", "0.0.0.0"]


# DB(Mariadb)
RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  mariadb-client \
  default-libmysqlclient-dev

# Nodejs
ARG NODE_MAJOR
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -
RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    nodejs

# Add Yarn to the sources list
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

# Rust
# Rustのインストール
COPY rustup-init /tmp/rustup-init
RUN /tmp/rustup-init -y

# Yarnのインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

# Aptfileに記載されたライブラリをインストール
# ImageMagickはライブラリ(imagemagick libvips)を必要とする(Aptfile記載)
COPY Aptfile /tmp/Aptfile
RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    yarn \
    build-essential \
    gnupg2 \
    curl \
    less \
    $(grep -Ev '^\s*#' /tmp/Aptfile | xargs)

# NodeJSのインストール
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt update
RUN apt-get install -y nodejs

# タイムゾーン設定
ENV TZ=Asia/Tokyo

# 環境変数設定
ARG APP_DIR
ENV GEM_HOME=/bundle
ENV BUNDLE_PATH $GEM_HOME

ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
  BUNDLE_BIN=$BUNDLE_PATH/bin

ENV PATH /$APP_DIR/bin:$BUNDLE_BIN:$PATH

# Uncomment this line if you store Bundler settings in the project's root
ENV BUNDLE_APP_CONFIG=.bundle

# Uncomment this line if you want to run binstubs without prefixing with `bin/` or `bundle exec`
ENV PATH /$APP_DIR/bin:$PATH

# RubyGemsアップグレード
RUN gem update --system && \
    gem install bundler

# アプリディレクトリへ移動
RUN mkdir -p /$APP_DIR
WORKDIR /$APP_DIR

