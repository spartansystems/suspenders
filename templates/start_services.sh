#!/usr/bin/env bash

# this script is executed once the web container started
echo "running start_services.sh in RACK_ENV=$RACK_ENV"
echo "assets"
if [ "$RACK_ENV" = "production" ] || [ "$RAILS_ENV" = "production" ]; then
    rake assets:precompile
    echo "precompiled"
else
    rm -rf public/assets
    echo "not precompiled"
fi

bundle exec puma -e production -C config/puma.rb

