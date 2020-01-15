docker build -t xabimoreno/multi-client:latest -t xabimoreno/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xabimoreno/multi-server:latest -t xabimoreno/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t xabimoreno/multi-worker:latest -t xabimoreno/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push xabimoreno/multi-client:latest
docker push xabimoreno/multi-server:latest
docker push xabimoreno/multi-worker:latest
docker push xabimoreno/multi-client:$SHA
docker push xabimoreno/multi-server:$SHA
docker push xabimoreno/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xabimoreno/multi-server:$SHA
kubectl set image deployments/client-deployment client=xabimoreno/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=xabimoreno/multi-worker:$SHA