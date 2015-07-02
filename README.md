# Taverna Player Portal

An example application that implements [Taverna Player](https://github.com/myGrid/taverna-player).

[![Build Status](https://travis-ci.org/myGrid/taverna-player-portal.svg?branch=master)](https://travis-ci.org/myGrid/taverna-player-portal)

## Docker
The easiest way to get the portal up and running is to use [Docker](https://www.docker.com/).

First, set up a taverna server container:

    docker run --name taverna -p 8080:8080 -d stain/taverna-server

Then set up the portal container:

    docker run --name taverna-portal --link taverna:taverna -p 3000:3000 -d fbacall/taverna-player-portal
