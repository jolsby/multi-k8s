docker build -t jolsby/multi-client:latest -t jolsby/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t jolsby/multi-server:latest -t jolsby/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t jolsby/multi-worker:latest -t jolsby/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push jolsby/multi-client:latest
docker push jolsby/multi-server:latest
docker push jolsby/multi-worker:latest

docker push jolsby/multi-client:$SHA
docker push jolsby/multi-server:$SHA
docker push jolsby/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jolsby/multi-server:$SHA
kubectl set image deployments/client-deployment client=jolsby/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jolsby/multi-worker:$SHA