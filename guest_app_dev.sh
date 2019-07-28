#kubectl apply -f aws_auth_configmap.yaml --kubeconfig=kube_config.yaml
#kubectl create -f namespace-dev.json
#kubectl create -f namespace-dev.json
#copy config file with dev namespace as file name kube_config.yaml
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-master-deployment.yaml --kubeconfig=kube_config.yaml
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-master-service.yaml --kubeconfig=kube_config.yaml
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-slave-deployment.yaml --kubeconfig=kube_config.yaml
kubectl apply -f https://k8s.io/examples/application/guestbook/redis-slave-service.yaml --kubeconfig=kube_config.yaml
kubectl apply -f https://k8s.io/examples/application/guestbook/frontend-deployment.yaml --kubeconfig=kube_config.yaml
kubectl apply -f https://k8s.io/examples/application/guestbook/frontend-service.yaml --kubeconfig=kube_config.yaml
kubectl get pods -l app=guestbook -l tier=frontend --kubeconfig=kube_config.yaml
kubectl apply --record -f guestbook-frontend-hpa-dev.yaml --kubeconfig=kube_config.yaml
kubectl get services -o wide --kubeconfig=kube_config.yaml