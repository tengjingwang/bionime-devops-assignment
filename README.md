# Bionime_assignment by TJWang

tengjingwang@gmail.com

# Usage

1. Have your AWS credential configured, or edit `aws_env.sh` file, then

```bash
source aws_env.sh
```

2. Edit `terraform/terraform.tfvars` and have necessary parameters set.

3. Make sure you have [terraform](https://www.terraform.io/downloads.html) installed.

4. use the following steps

```bash
cd terraform
terraform --init
terraform apply --auto-approve
```

The AWS resources should be up and running

5. This setup provides appropriate IAM role/policy to said EC2 instance. But do not install cloudwatch logs agents itself. You have to connect to the server and [install them yourselves](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/QuickStartEC2Instance.html)

```bash
sudo yum update -y
sudo yum install -y awslogs
sudo systemctl start awslogsd
```

## Tasks

- [O] VPC w/ 1 pub and 1 pri subnet
   - [O] routing tables
   - [O] test in each instance and make sure they can connect each other
   - [O] RDS/MySQL instance in said pri subnet
   - [O] ECS instance in pub subnet
       - [O] get an instance up
           - [O] password?
       - [X] Cloudwatch agent + log to cloudwatch
            probably not, role/permissions will do
           - [O] Let me see if I can get away w/o using packer
           - [O] iam roles
       - [X] careful with security group
            not specified in the assignment
           - [O] still gonna set them tho for testing...

- [X] cleanup
- [X] test
- [X] deliver
