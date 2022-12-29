#!/bin/bash

docker stop perm_test || true
docker rm perm_test --force || true
docker rmi perm-test:$1 || true

go build -o binaryFiles/main

docker build . -t perm-test:$1
docker run --name perm_test -d -p 8080:8080 perm-test:$1
docker exec -it perm_test bash
