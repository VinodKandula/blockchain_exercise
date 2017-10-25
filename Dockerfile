FROM alpine:3.6
MAINTAINER Stuart Ingram <stuart.ingram@gmail.com>

ENV BUILD_PACKAGES  curl curl-dev ruby-dev build-base
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler bash

# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES

RUN mkdir /usr/app
WORKDIR /usr/app

COPY Gemfile /usr/app/
COPY Gemfile.lock /usr/app/
RUN bundle install && \
    apk del $BUILD_PACKAGES && \
    rm -rf /var/cache/apk/*

COPY . /usr/app

EXPOSE 4567
EXPOSE 7946
EXPOSE 7373

CMD ["/usr/bin/ruby", "/usr/app/lib/server.rb"]
