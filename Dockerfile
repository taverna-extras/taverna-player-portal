FROM ruby:2.1.2

RUN apt-get update -qq && apt-get install -y build-essential

# Database uses SQLite3
RUN apt-get -y install sqlite libsqlite3-dev

# To parse t2flows:
RUN apt-get install -y libxml2-dev libxslt1-dev

# To generate t2flow images
RUN apt-get install -y libtool libmagickwand-dev graphviz ImageMagick

RUN apt-get install -y nodejs

ADD . /taverna-player-portal

WORKDIR /taverna-player-portal

ENV RAILS_ENV production

RUN bundle install

RUN bundle exec rake db:setup

# Generate secret
RUN cp config/initializers/secret_token.rb.example config/initializers/secret_token.rb
RUN sed -i 's/key = ""/key = "'"`bundle exec rake secret`"'"/' config/initializers/secret_token.rb

RUN cp config/initializers/portal_configuration.rb.example config/initializers/portal_configuration.rb

RUN cp config/initializers/taverna_server.rb.example config/initializers/taverna_server.rb

RUN bundle exec rake assets:precompile

EXPOSE 3000

ENTRYPOINT ["/taverna-player-portal/docker/entrypoint.sh"]

CMD ["rails", "server"]

