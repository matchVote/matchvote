FROM ruby:2.2.6
LABEL maintainer="matchVote <admin@matchvote.com>"
LABEL version="1.1"

RUN apt-get update \
    && apt-get install -y build-essential libpq-dev nodejs postgresql-client-9.4 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src/app

COPY Gemfile* ./
RUN bundle install
COPY . .

CMD bin/start
