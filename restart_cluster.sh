#!/bin/bash

export COMPOSE_HTTP_TIMEOUT=300

docker-compose restart

docker-compose logs -f