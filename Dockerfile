FROM library/ruby:2.4.1-slim
MAINTAINER Michael Dungan <mpd@jesters-court.net>

RUN gem update bundler && \
    apt-get update && \
    apt-get install -y \
      build-essential \
      git \
      libmagickcore-dev \
      libmagickwand-dev \
      wget && \
      wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && \
      chmod +x /usr/local/bin/dumb-init && \
      mkdir /srv/fakeimage

COPY Gemfile /srv/fakeimage
COPY Gemfile.lock /srv/fakeimage
WORKDIR /srv/fakeimage
RUN bundle config github.https true && \
    bundle install && \
    apt-get clean && \
    apt-get remove -y build-essential git && \
    apt-get purge && \
    apt-get autoremove -y

COPY . /srv/fakeimage

EXPOSE 4567

CMD ["dumb-init", "ruby", "fakeimage.rb", "-o", "0.0.0.0"]
