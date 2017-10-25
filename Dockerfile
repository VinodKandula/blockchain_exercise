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

# Add serf binary
RUN curl -o /tmp/serf_0.8.1_linux_amd64.zip https://releases.hashicorp.com/serf/0.8.1/serf_0.8.1_linux_amd64.zip && \
    cd /usr/local/bin && \
    unzip /tmp/serf_0.8.1_linux_amd64.zip && \
    chmod +x serf

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

CMD /usr/app/startup.sh
