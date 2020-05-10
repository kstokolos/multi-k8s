docker build -t kstokolos/multi-client:latest -t kstokolos/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kstokolos/multi-server:latest -t kstokolos/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kstokolos/multi-worker:latest -t kstokolos/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kstokolos/multi-client:latest
docker push kstokolos/multi-server:latest
docker push kstokolos/multi-worker:latest

docker push kstokolos/multi-client:$SHA
docker push kstokolos/multi-server:$SHA
docker push kstokolos/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=kstokolos/multi-server:$SHA
kubectl set image deployments/client-deployment client=kstokolos/muilti-client:$SHA
kubectl set image deployments/worker-deployment worker=kstokolos/muilti-worker:$SHA
