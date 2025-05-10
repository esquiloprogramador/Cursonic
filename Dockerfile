FROM ruby:3.3

# Variáveis para usuário customizado
ARG APP_USER
ARG APP_UID
ARG APP_GID

# Dependências do sistema
RUN apt-get update -qq && apt-get install -y \
  build-essential libpq-dev nodejs npm postgresql-client

RUN useradd -u $APP_UID -ms /bin/bash $APP_USER
WORKDIR /app

# Instala bundler e gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN gem install rails

USER $APP_USER
