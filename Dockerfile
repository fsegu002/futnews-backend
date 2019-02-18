FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /futnews-api
WORKDIR /futnews-api
COPY Gemfile /futnews-api/Gemfile
COPY Gemfile.lock /futnews-api/Gemfile.lock
RUN bundle install
COPY . /futnews-api

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 9636

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]