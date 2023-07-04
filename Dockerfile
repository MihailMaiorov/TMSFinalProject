FROM ruby:3.0.2
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN apt update && \
  apt install -qq -y curl --fix-missing --no-install-recommends && \
  curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  apt update && \
  apt install -qq -y nodejs build-essential libpq-dev wget git  --fix-missing --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*
RUN bundle config set without 'development test' && \
  bundle install -j 4
RUN npm install --global yarn
ARG BUILD_ENV=production
ENV RAILS_ENV=$BUILD_ENV
COPY . .
RUN bundle exec rails assets:precompile
CMD  rails db:migrate && rails s
