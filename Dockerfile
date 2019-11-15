FROM ruby:2.3.7
LABEL maintainer="matchVote <admin@matchvote.com>"
LABEL version="1.3"

RUN apt-get update \
    && apt-get install -y build-essential libpq-dev nodejs postgresql-client-9.6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install --jobs 12 --without development test
ENV RAILS_ENV production
ENV RAKE_ENV production
COPY . .

ARG AWS_REGION
ARG MV_PROFILE_PIC_BUCKET
RUN SECRET_KEY_BASE=$(rake secret) rake assets:precompile

CMD bin/start

