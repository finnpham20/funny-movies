FROM ruby:3.0.0

ENV RAILS_ENV production
ENV INSTALL_PATH /myapp

WORKDIR $INSTALL_PATH

RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client

COPY . .

RUN gem install bundler
RUN bundle config set without 'development'
RUN bundle install --jobs=3 --retry=3 && mkdir -p log

EXPOSE 3000
CMD rails s
