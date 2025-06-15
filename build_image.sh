#!/bin/sh

IMAGE=$(cat .docker/image_name)
docker build -t $IMAGE .
