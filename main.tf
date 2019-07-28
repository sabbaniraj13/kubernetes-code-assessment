module "my-cluster" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = "demo"
  subnets      = ["subnet-d79bf8f9", "subnet-4edfeb04", "subnet-59f59405"]
  vpc_id       = "vpc-b3be0ec9"

  worker_groups = [
    {
      instance_type = "t2.large"
      asg_max_size  = 2
      tags = [{
        key                 = "application"
        value               = "guestbook"
        propagate_at_launch = true
      }]
    }
  ]

  tags = {
    environment = "test"
  }
}

terraform {
  backend "s3" {
    bucket = "code-assessment-terraform-state"
    key    = "eksterraform.tf"
    region = "us-east-1"
  }
}