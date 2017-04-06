FROM ruby:2.2.6
MAINTAINER matchVote <admin@matchvote.com>

ENV PHANTOMJS_VERSION 2.1.1

#### PhantomJS Installation ####
RUN mkdir /tmp/phantomjs \
    && curl -SL "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2" \
           | tar -xj --strip-components=1 -C /tmp/phantomjs \
    && mv /tmp/phantomjs/bin/phantomjs /usr/bin \
    && rm -rf /tmp/phantomjs

RUN apt-get update \
    && apt-get install -y build-essential libpq-dev nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src/app

COPY Gemfile* ./
RUN bundle install
