FROM ruby:2.4.2

WORKDIR /zip2tz
ADD . /zip2tz

RUN bundle install
