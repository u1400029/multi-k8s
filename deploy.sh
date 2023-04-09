docker build -t u1400029/multi-client:latest -t u1400029/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t u1400029/multi-server:latest -t u1400029/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t u1400029/multi-worker:latest -t u1400029/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push u1400029/multi-client:latest
docker push u1400029/multi-server:latest
docker push u1400029/multi-worker:latest

docker push u1400029/multi-client:$SHA
docker push u1400029/multi-server:$SHA
docker push u1400029/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=u1400029/multi-server:$SHA
kubectl set image deployments/client-deployment client=u1400029/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=u1400029/multi-worker:$SHA