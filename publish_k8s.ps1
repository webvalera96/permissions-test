docker login registry.cluster.local
docker rmi perm-test:1.0
docker build . -t registry.cluster.local/perm-test:1.0
docker push registry.cluster.local/perm-test:1.0

kubectl create namespace perm-test

kubectl apply -f docker-registry-key.yaml --namespace perm-test
kubectl apply -f dc.yaml --namespace perm-test
kubectl apply -f ap.yaml --namespace perm-test


