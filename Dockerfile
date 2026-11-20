FROM library/ruby:4.0.10-alpine
LABEL org.opencontainers.image.authors="mpd@jesters-court.net"

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

COPY Gemfile \
     Gemfile.lock \
     fakeimage.gemspec \
     /srv/fakeimage/
WORKDIR /srv/fakeimage
RUN bundle config github.https true && \
    bundle install && \
    apk del build-base gcc wget

COPY . /srv/fakeimage

EXPOSE 4567

CMD ["dumb-init", "bundle", "exec", "puma", "config.ru"]
