#!/bin/bash

PREVIOUS_IMAGE=$(cat previous_image.txt)

docker stop myapp || true
docker rm myapp || true

docker run -d --name myapp -p 80:3000 $PREVIOUS_IMAGE
