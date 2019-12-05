docker build -t stanlee94/multi-client:latest -t stanlee94/multi-client:$SHA ./client
docker build -t stanlee94/multi-worker:latest -t stanlee94/multi-worker:$SHA ./worker
docker build -t stanlee94/multi-server:latest -t stanlee94/multi-server:$SHA ./server

docker push stanlee94/multi-client:latest
docker push stanlee94/multi-client:$SHA
docker push stanlee94/multi-worker:latest
docker push stanlee94/multi-worker:$SHA
docker push stanlee94/multi-server:latest
docker push stanlee94/multi-server:$SHA

kubectl apply -f k8s

# Force Kubernetes to update the deployment based on the new image
kubectl set image deployments/server-deployment server=stanlee94/multi-server:$SHA
kubectl set image deployments/client-deployment client=stanlee94/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stanlee94/multi-worker:$SHA