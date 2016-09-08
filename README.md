# Taverna Player Portal

[![Build Status](https://travis-ci.org/myGrid/taverna-player-portal.svg?branch=master)](https://travis-ci.org/myGrid/taverna-player-portal)

An example application that implements [Taverna Player](https://github.com/myGrid/taverna-player).

## Docker
The easiest way to get the portal up and running is to use [Docker](https://www.docker.com/).

First, set up a taverna server container:

    docker run --name taverna -p 8080:8080 -d taverna/taverna-server

Then set up the portal container:

    docker run --name taverna-portal --link taverna:taverna -p 3000:3000 -d fbacall/taverna-player-portal
    
## Manual Setup (for development)
### Ubuntu 14.04 (or similar)
Install required packages

    sudo apt-get install sqlite libsqlite3-dev libxml2-dev libxslt1-dev libtool libmagickwand-dev graphviz ImageMagick ghostscript nodejs git
                         
#### Install Ruby 2.2.2

First, install RVM using the commands listed here: https://rvm.io/

Then run (you may need to restart your terminal first)

    rvm install 2.2.2
    
#### Clone the portal

    git clone https://github.com/myGrid/taverna-player-portal.git
    cd taverna-player-portal
    
#### Install gems

    gem install bundler

    bundle install
    
#### Taverna Server configuration

    cp config/initializers/taverna_server.rb.example config/initializers/taverna_server.rb
    
You will need to edit `config/initializers/taverna_server.rb` in your favourite text editor to include the location and credentials of the Taverna Server instance you wish to use.

#### Set up the database

    bundle exec rake db:setup
    
#### Run the server

    bin/rails s
    
This will start the application at http://localhost:3000/
    
#### Run the worker
To start the DelayedJob worker, which handles asynchronous tasks such as polling Taverna Server, run the following in a seperate terminal window:
    
    rake jobs:work
    
*Note: remember to restart the worker to reflect any back-end code changes*

## API

The portal has a basic API (provided by Rails) for listing and uploading workflows.

### Authentication

The API uses HTTP Basic authentication, where the username is your email address, and the password is your password. Actions such as uploading a workflow require authentication. Other actions can be perform anonymously.

### Workflows

#### Listing workflows

    GET /workflows.json
    
#### Fetching a workflow's metadata

    GET /workflows/1.json
    
Where the ID of the workflow is `1`

#### Uploading a workflow

    POST /workflows.json
    
Where the body of the POST is a JSON document, structured as follows:

    { "workflow" : { "document" : "data:application/octet-stream;base64,<<<workflow here>>>" } }
    
Where `<<<workflow here>>>` is a Base64 encoded T2Flow workflow.

Make sure to set the `Content-Type` of your request to `application/json`.

##### Example using curl

    curl -u joebloggs@example.com -X POST -H "Content-Type: application/json" -d@my_post_body.json http://localhost:3000/workflows.json 

### Runs

The workflow run API is provided by Taverna Player, and is documented here: https://github.com/myGrid/taverna-player/wiki/JSON-API-Documentation
