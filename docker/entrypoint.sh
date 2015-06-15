#!/bin/bash

# Taverna Server settings
sed -i 's,config.server_address *=.*,config.server_address = "'"$TAVERNA_SERVER_URL"'",'  /taverna-player-portal/config/initializers/taverna_server.rb
sed -i 's,config.server_username *=.*,config.server_username = "'"$TAVERNA_SERVER_USERNAME"'",'  /taverna-player-portal/config/initializers/taverna_server.rb
sed -i 's,config.server_password *=.*,config.server_password = "'"$TAVERNA_SERVER_PASSWORD"'",'  /taverna-player-portal/config/initializers/taverna_server.rb

# Generate a secret
sed -i 's/key = ""/key = "'"`bundle exec rake secret`"'"/' config/initializers/secret_token.rb

/taverna-player-portal/script/delayed_job --queue=player start

exec "$@"
