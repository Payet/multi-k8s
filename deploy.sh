
docker build -t bpayet/multi-client:latest -t bpayet/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t bpayet/multi-server:latest -t bpayet/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t bpayet/multi-worker:latest -t bpayet/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push bpayet/multi-client:latest
docker push bpayet/multi-server:latest
docker push bpayet/multi-worker:latest

docker push bpayet/multi-client:$GIT_SHA
docker push bpayet/multi-server:$GIT_SHA
docker push bpayet/multi-worker:$GIT_SHA

kubectl apply -f ./k8s

kubectl set image deployments/server-deployment server=bpayet/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=bpayet/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=bpayet/multi-worker:$GIT_SHA