FROM ruby:2.2

MAINTAINER Spartan Systems

# System dependencies for gems.
RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential

RUN mkdir /app

# Install gems separately here to take advantage of container caching of `bundle install`.
# Also, ensure that gems are installed as the web user and not system-wide so that we can run
# `fig run web bundle install` and the web user will have permissions to update the shared Gemfile.lock.
ADD Gemfile /app/
ADD Gemfile.lock /app/
WORKDIR /app/
RUN bundle install

# Add the whole application source to the image and own it all by web:web.
# Note: this is overwritten in development because fig mounts a shared volume at /app.
ADD . /app/

WORKDIR /app
RUN chmod 744 bin/start_services.sh


# Clean up APT and /tmp when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3000

CMD bin/start_services.sh

