#kubectl apply -f config-map-aws-auth_recon.yaml --kubeconfig=kubeconfig_recon
#kubectl create -f namespace-dev.json
#kubectl create -f namespace-dev.json
#copy config file with dev namespace as file name config_prod
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-master-deployment.yaml --kubeconfig=config_prod
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-master-service.yaml --kubeconfig=config_prod
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-slave-deployment.yaml --kubeconfig=config_prod
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-slave-service.yaml --kubeconfig=config_prod
kubectl apply -f https://k8s.io/examples/application/guestbook/frontend-deployment.yaml --kubeconfig=config_prod
kubectl apply -f https://k8s.io/examples/application/guestbook/frontend-service.yaml --kubeconfig=config_prod
kubectl get pods -l app=guestbook -l tier=frontend --kubeconfig=config_prod
kubectl apply --record -f guestbook-frontend-hpa-prod.yaml --kubeconfig=config_prod
kubectl get services -o wide --kubeconfig=config_prod