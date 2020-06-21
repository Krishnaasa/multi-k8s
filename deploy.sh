docker build -t krishna201294/multi-client:latest -t krishna201294/mult-client:$SHA -f ./client/Dockerfile ./client
docker build -t krishna201294/multi-server:latest -t krishna201294/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t krishna201294/multi-worker:latest -t krishna201294/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push krishna201294/multi-client:latest
docker push krishna201294/multi-server:latest
docker push krishna201294/multi-worker:latest

docker push krishna201294/multi-client:$SHA
docker push krishna201294/multi-server:$SHA
docker push krishna201294/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=krishna201294/multi-server:$SHA
kubectl set image deployments/client-deployment client=krishna201294/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=krishna201294/multi-worker:$SHA
