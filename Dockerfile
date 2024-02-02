FROM ruby:3.1.2

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn nodejs postgresql-client

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
ADD start.sh /
RUN chmod +x /start.sh

ARG DATABASE_ADAPTER=postgresql
ARG DATABASE_ENCODING=unicode
ARG DATABASE_NAME=database_name
ARG DATABASE_USERNAME=database_username
ARG DATABASE_PASSWORD=database_password
ARG DATABASE_HOST=database_host
ARG DATABASE_PORT=5432
ARG DATABASE_POOL=5

RUN RAILS_ENV=production bundle exec rake assets:precompile

CMD ["/start.sh"]