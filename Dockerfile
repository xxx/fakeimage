FROM library/ruby:3.1.2-alpine
MAINTAINER Michael Dungan <mpd@jesters-court.net>

RUN gem update bundler && \
    apk add --no-cache \
      build-base \
      dumb-init \
      gcc \
      git \
      imagemagick \
      imagemagick-dev \
      wget && \
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
