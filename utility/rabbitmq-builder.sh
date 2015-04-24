#!/usr/bin/env bash

WORKING_DIRECTORY=$(pwd)
PROJECT_DIRECTORY=$(cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd)

if [[ ${WORKING_DIRECTORY} != ${PROJECT_DIRECTORY}* ]]; then
    echo "RabbitMQ builder must be executed from within the docker-archlinux project folder."
    exit 1
fi

DOCKER_WORKING_DIRECTORY=${WORKING_DIRECTORY#"$PROJECT_DIRECTORY"}

if [ "$TERM" == "dumb" ]; then 
    DOCKER_RUN_OPTIONS=""
else
    DOCKER_RUN_OPTIONS="-it"
fi

docker run $DOCKER_RUN_OPTIONS --rm \
  -v $PROJECT_DIRECTORY:/project \
  -w="/project${DOCKER_WORKING_DIRECTORY}/" \
  --privileged \
  gainmaster/archlinux:base-devel aur-build-tar rabbitmq