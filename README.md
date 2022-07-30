# Terraform Project 

## Project Overview

Terraform project to provision AWS resources for a backend App. Configure the instance using ansible, then deploy the application from a docker image using jenkins pipeline.


## Objectives

- Use Terraform to configure AWS resources
- Use the S3 bucket to state management file
- Use DynamoDB to lock sync terraform apply
- Use Lambda Trigger to detect changes in the state file and send the email by SES service


## Tools Used

- Git & GitHub
- AWS & AWS-CLI
- Python3
- Jenkins
- Ansible
- Terraform
- Docker & Docker Hub

## Project Steps



1. [Provision AWS Resources](#Provision-AWS-Resources)
1. [Terraform Environment](#Environment)
1. [Configure Instance Using Ansible](#Ansible-Configuration)
1. [Jenkins Configuration](#Jenkins-Configuration)

### Provision AWS Resources

1. Create vpc
1. Create internet gateway (IGW)
1. Create NAT gateway
1. Create 2 public subnets and 2 private subnets
1. Create public route table map to (IGW)
1. Create private route table map to NAT gateway
1. Create security group which allow ssh from 0.0.0.0/0
1. Create security group that allow ssh and port 3000 from vpc cidr only
1. Create ec2(bastion) in public subnet with security group from 7
1. Create ec2(application) private subnet with security group from 8
1. Create RDS (MYSQL) 
1. Create elastic cache (Redis)
1. Create application load balancer to expose the nodejs app on port 80

### Environment
1. Create two workspaces dev and prod
```
$ terraform workspace new prod
$ terraform workspace new dev
```
2. Create two variable definition files(.tfvars) for the two environments
3. Separate network resources into network module
4. Apply code to create two environments one in `us-east-1` and `eu-central-1`
5. Verify email in SES service
6. Create lambda function to send email

```
import json
import boto3
from botocore.exceptions import ClientError

import json
import boto3
from botocore.exceptions import ClientError


def lambda_handler(event, context):
    ses_client = boto3.client("ses", region_name="us-east-1")
    CHARSET = "UTF-8"
    response = ses_client.send_email(
        #TODO: Type the destination email
        Destination={
            "ToAddresses": [
                <"email@gmail.com">,
            ],
        },
        Message={
            "Body": {
                "Text": {
                    "Charset": CHARSET,
                    "Data": "Hello, world!",
                }
            },
            "Subject": {
                "Charset": CHARSET,
                "Data": "Amazing Email Tutorial",
            },
        },
        #TODO: Type the source email
        Source=<"email@gmail.com">,
    )


```

7. Create trigger to detect changes in state file and send the email

### Ansible Configuration
- ##### Configure ansible to run over private ips through bastion (~/.ssh/config) 
    - To Make ansible script access the private instance, Create file `~/.ssh/config` with `SSH ProxyCommand` to access the private instance directory
 
        ```bash 
        host bastion
            HostName <public-ip>
            User ec2-user
            identityFile ~/.ssh/test-keypair.pem
        host privateInstance
            HostName <private-ip>
            user ec2-user
            ProxyCommand ssh bastion -W %h:%p
            identityFile ~/.ssh/test-keypair.pem
        ```

    - Now could have configured ssh config file all you need to type `ssh privateInstance`
  
-  ##### Create an ansible script to configure application ec2 (private) to run  as Jenkins slaves(agent)
    - Make the `hosts` in the ansible playbook work on the `privateInstace`, after that run the ansible playbook to run configuration directory on the private instance.
in ` /ansible` directory, run

        ```bash
        ansible-playbook -i inventory playbook.yaml
        ```

### Jenkins Configuration

- ##### Configure slave in Jenkins dashboard (with private ip)

    ![This is a alt text.](/images/ec2-agent.png)
    
    - Launch method at node configurations:
    
    ![This is a alt text.](/images/launch-method.png)
    
    1. Download `agent.jar` and copy to the private instance using ansible to this path `~/bin/agent.jar`
    1. Run the following command at Launch command
        
    ```bash
    ssh privateInstance exec java -jar /home/ec2-user/bin/agent.jar 
    ```

 - ##### Create a pipeline to deploy nodejs_example from branch (rds_redis)

- ### Finally:
    - Calling loadbalancer_url/db and /redis

- ### Extra Notes:
    - Adding the `inventory.tf` to generate the ip of the private instance and add it to the `inventory` ansible file.
    - Adding the `hosts.tpl` to handle the structure of the `inventory` file
    - The `jenkinsfile` used to create the the jenkins pipeline of [nodejs-app](https://github.com/MahmoudAbdelFatah/jenkins_nodejs_example) from branch `rds_redis`
