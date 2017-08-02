FROM sickp/alpine-ruby:2.4.1-r1
MAINTAINER Michael Dungan <mpd@jesters-court.net>

RUN gem update bundler && \
    apk add --no-cache \
      build-base \
      gcc \
      git \
      imagemagick \
      imagemagick-dev \
      wget && \
    wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && \
    chmod +x /usr/local/bin/dumb-init && \
    mkdir /srv/fakeimage

COPY Gemfile /srv/fakeimage
COPY Gemfile.lock /srv/fakeimage
WORKDIR /srv/fakeimage
RUN bundle config github.https true && \
    bundle install && \
    apk del build-base gcc wget git

COPY . /srv/fakeimage

EXPOSE 4567

CMD ["dumb-init", "ruby", "fakeimage.rb", "-o", "0.0.0.0"]
