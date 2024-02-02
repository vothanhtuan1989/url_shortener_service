#!/bin/bash

RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production rails s -b 0.0.0.0