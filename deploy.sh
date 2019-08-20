docker build -t prashantshivade/multi-client:latest -t prashantshivade/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t prashantshivade/multi-server:latest -t prashantshivade/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t prashantshivade/multi-worker:latest -t prashantshivade/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push prashantshivade/multi-client:latest
docker push prashantshivade/multi-server:latest
docker push prashantshivade/multi-worker:latest

docker push prashantshivade/multi-client:$SHA
docker push prashantshivade/multi-server:$SHA
docker push prashantshivade/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=prashantshivade/multi-server:$SHA
kubectl set image deployments/client-deployment client=prashantshivade/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=prashantshivade/multi-worker:$SHA