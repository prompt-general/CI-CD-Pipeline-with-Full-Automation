#!/bin/bash
IMAGE=$1
PREVIOUS_IMAGE_FILE="previous_image.txt"

if docker ps -q --filter "name=myapp"; then
  docker tag $IMAGE myapp:previous || true
  echo "myapp:previous" > $PREVIOUS_IMAGE_FILE
fi

docker stop myapp || true
docker rm myapp || true

docker run -d --name myapp -p 80:3000 $IMAGE

sleep 5
curl -f http://localhost:3000/health || bash devops/scripts/rollback.sh
