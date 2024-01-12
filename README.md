# Deploying Project with Jenkins, Terraform, and Docker on AWS

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

## Step 3: Initialize Terraform
Run the following commands to initialize `Terraform`:
```js
terraform init


