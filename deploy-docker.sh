#!/bin/sh

set -ex

IMAGE_NAME=caveman_heroku_docker_test
APP_NAME=caveman-heroku-docker-test

#heroku apps:create caveman-heroku-docker-test

heroku container:login

docker build -t $IMAGE_NAME .

docker tag $IMAGE_NAME registry.heroku.com/$APP_NAME/web

docker push registry.heroku.com/$APP_NAME/web

heroku container:release web -a $APP_NAME
