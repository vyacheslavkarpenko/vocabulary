FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

ENV RAILS_ROOT /vocabulary
ENV RAILS_ENV production

RUN mkdir $RAILS_ROOT

WORKDIR $RAILS_ROOT
COPY Gemfile $RAILS_ROOT/Gemfile
COPY Gemfile.lock $RAILS_ROOT/Gemfile.lock
RUN gem install bundler -v 2.1.4
RUN bundle install

COPY . $RAILS_ROOT
RUN bundle exec rake tmp:clear log:clear
RUN rm -rf $RAILS_ROOT/public/*
VOLUME $RAILS_ROOT/log

EXPOSE 3000
# precompile asset
CMD ["RAILS_ENV=production", "rake", "assets:precompile"]

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0", "-e", "$RAILS_ENV"]

