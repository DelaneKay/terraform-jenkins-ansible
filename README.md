# Deploying Project with Jenkins, Terraform, and Ansible on AWS

This guide outlines the steps to deploy a project containing a Jenkinsfile, Terraform configuration, and Ansible playbook on AWS using Terraform and Docker.

## Prerequisites
+ `Jenkins` installed and configured
+ `Node.js` installed
+ `Docker` installed
+ `Terraform` installed
+ AWS account with appropriate permissions

## Step 1: Jenkins Pipeline Setup
1. Create a new pipeline in `Jenkins`.
2. Configure the pipeline to use the `Jenkinsfile` provided in script above.

## Step 2: Configure Terraform
Create a file named `main.tf` with the provided Terraform configuration as in the script above.

## Step 3: Run Ansible Playbook
After Terraform applies the changes, obtain the public IP address of the EC2 instance and SSH into it:
```js
ssh -i /path/to/your/private-key.pem ubuntu@<instance-public-ip>
```

Run the Ansible playbook:

```js
ansible-playbook -i inventory playbook.yaml
```

## Step 4: Access the Deployed App
Visit your AWS EC2 instance's public IP address in a web browser to access the deployed application.
```js
http://<AWS_EC2_Public_IP>
```
