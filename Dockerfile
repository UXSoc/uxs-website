FROM ruby:2.5.1
LABEL maintainer="Xavi Ablaza <xlablaza@gmail.com>"

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  curl -sL https://deb.nodesource.com/setup_8.x | bash && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && \
  apt-get upgrade -y && \
  apt-get install -y build-essential libpq-dev nodejs postgresql-client nodejs yarn && \
  # Keep image size small:
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  ln -nfs /usr/lib/x86_64-linux-gnu/libssl.so.1.0.2 /usr/lib/x86_64-linux-gnu/libssl.so

ENV APP=/app
RUN mkdir $APP
WORKDIR $APP

ENV BUNDLE_GEMFILE=$APP/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle \
  PATH=./bin:$PATH \
  RAILS_ENV=production \
  NODE_ENV=production \
  SECRET_KEY_BASE=secret_key_base

RUN mkdir $BUNDLE_PATH

ADD Gemfile $APP/Gemfile
ADD Gemfile.lock $APP/Gemfile.lock

RUN gem install bundler --no-ri --no-rdoc && \
  bundle config https://gem.fury.io/bloomsolutions/ $FURY_AUTH && \
  bundle install --jobs 20 --retry 5 --without development test

ADD . $APP

RUN cp $APP/config/database.yml.sample $APP/config/database.yml && \
  bundle exec rails assets:precompile
