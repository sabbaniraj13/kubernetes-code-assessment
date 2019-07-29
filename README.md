# kubernetes-code-assessment

objective:

The Objective of this to perform the below taks mentioned tasks. These taks are related to installation, monitoring and maintenance of an application. The below taks are performed choosing the aws public cloud. 

Tasks:

1. Create a Kubernetes cluster on GCP (GCP gives free credits on signup so those should suffice for this exercise) or AWS. If possible share a script / code which can be used to create the cluster.

2. Install nginx ingress controller on the cluster. For now, we consider that the user will add public IP of ingress LoadBalancer to their /etc/hosts file for all hostnames to be used. So do not worry about DNS resolution.

3. On this cluster, create namespaces called staging and production. 

4. Install guest-book application on both namespaces.

5. Expose staging application on hostname(stage.x)

6. Expose production application on hostname(prod.x)

7. Implement a pod autoscaler on both namespaces which will scale frontend pod replicas up and down based on CPU utilization of pods. 

8. Write a script which will demonstrate how the pods are scaling up and down by increasing/decreasing load on existing pods.

9. Write a wrapper script which does all the steps above. Mention any pre-requisites in the README.md at the root of your repo.

Prerequisite:
Install the Latest AWS CLI
Download and Install latest version of Terraform - Terraform v0.12.5	
Configure AWS CLI Credentials
Install and Configure kubectl 
Install aws-iam-authenticator
create an s3 bucket to maintain the terraform state ex: "code-assessment-terraform-state"

Deployment Instructions:

The list of below taks are considered to be involving 
a) Creating the EKS Cluster
b) Create two namespaces 
c) Deploy guest-book application on both
d) Application Loadbalancer with host based routing (I am planning to use ALB ingress controller instead of nginx ingress controller becouse of AWS cloud)

Assumong we've AWS account and Terraform installed. Configure IAM credentials so that Terraform will be able to act on our behalf.
These resources to exist within security groups that allow communication and coordination are created within the module.
Virtual Private Cloud (VPC) and subnets where intend to put the EKS resources.

a) Creating the EKS Cluster

The script will create AutoScaling Group containing 2 t2.large instances based on the latest EKS Amazon Linux 2 AMI: Operator managed Kuberneted worker nodes for running Kubernetes deployments



Instructions :
Download the code form the got repo : https://github.com/sabbaniraj13/kubernetes-code-assessment

1. Intialize terraform
	terraform init

2. Make sure main.tf variables cluster name,vpc, subnet and s3 bucket are passed

3. Execute command : terraform apply
   This will create Ingress and Egress security groups resources and autoscaling group 
   It creates kube_config.yaml in the current directory and aws_auth_configmap.yaml

4. Test your connection with cluster
   cmd : kubectl get svc --kubeconfig=kube_config.yaml
   
	NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
	kubernetes   ClusterIP   10.100.0.1   <none>        443/TCP   68m

    λ kubectl get nodes --watch --kubeconfig=kube_config.yaml
	NAME                           STATUS   ROLES    AGE   VERSION
	ip-172-31-80-85.ec2.internal   Ready    <none>   79m   v1.12.7
	ip-172-31-80-85.ec2.internal   Ready   <none>   79m   v1.12.7

    
b) Create two names space and deploy guest-book application

Execute the below commands for creating the developemnt and production name space :

   cmd : kubectl apply -f namespace-dev.json --kubeconfig=kube_config.yaml
         kubectl apply -f namespace-prod.json --kubeconfig=kube_config.yaml

Verify the name space files created for development and production Refer file name : namespace-prod.json and namespace-dev.json

Install guest.book application on both the namespaces :

guest book app installtion namespace : development

   cmd : sh guest_app_dev.sh

guest book app installtion name space : production
  
   cmd : sh guest_app_prod.sh


Load test with Siege:

To force the HPA into action, we can use Siege, an HTTP load testing and benchmark utility. Siege is a multi-threaded load testing tool and has a few other capabilities included to make it a good option for putting some force onto a simple web app.

Web References
https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html
https://learn.hashicorp.com/terraform/aws/eks-intro
https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html
https://www.terraform.io/downloads.html
https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
https://docs.aws.amazon.com/cli/latest/reference/eks/update-kubeconfig.html
https://docs.aws.amazon.com/eks/latest/userguide/eks-guestbook.html
