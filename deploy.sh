#build images
docker build -t swatis1209s/multi-container-client:latest -t swatis1209s/multi-container-client:$SHA -f ./client/Dockerfile ./client
docker build -t swatis1209s/multi-container-server:latest -t swatis1209s/multi-container-server:$SHA -f ./client/Dockerfile ./server
docker build -t swatis1209s/multi-container-worker:latest -t swatis1209s/multi-container-worker:$SHA -f ./client/Dockerfile ./worker
#push images
docker push swatis1209s/multi-container-client:latest
docker push swatis1209s/multi-container-client:$SHA

docker push swatis1209s/multi-container-server:latest
docker push swatis1209s/multi-container-server:$SHA

docker push swatis1209s/multi-container-worker:latest
docker push swatis1209s/multi-container-worker:$SHA

#no need to login to kubectl since in .travis.yml file we already logged in kubectl using google cloud installation
kubectl apply -f k8s
#Imperative command to set latest image if version is not mentioned
kubectl set image deployments/server-deployment server=swatis1209s/multi-container-server:$SHA
kubectl set image deployments/client-deployment client=swatis1209s/multi-container-client:$SHA
kubectl set image deployments/worker-deployment worker=swatis1209s/multi-container-worker:$SHA
