#!/bin/bash

sudo docker stop perm_test || true
sudo docker rm perm_test --force || true
sudo docker rmi perm-test:1.0 || true

CGO_ENABLED=0 go build -o binaryFiles/main ./src

sudo docker build . -t perm-test:1.0
sudo docker run --name perm_test -d -p 8080:8080 perm-test:1.0
echo "http://127.0.0.1:8080/Valera"
sudo docker exec -it perm_test bash
