pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/DelaneKay/terraform-ansible']])
            }
        }

        stage('Terraform init') {
            steps {
                sh ("terraform init") // Initialize Terraform in the workspace.
            }
        }
        
        stage('Terraform Apply') {
            steps {
                sh ("terraform apply --auto-approve") // Apply the Terraform configuration.
            }
        }

        stage('Retrieve EC2 IP') {
            steps {
                script {
                    EC2_IP = sh(script: "terraform output terraform-ansible_ip", returnStdout: true).trim()
                    echo "The EC2 IP is: ${EC2_IP}"
                }
            }
        }

        stage('Run Ansible') {
            steps {
                sh ("ansible-playbook -i ${EC2_IP}, --private-key ~/AWSDevOps.pem setup_ec2-playbook.yaml") // Run the Ansible playbook on the EC2 instance.
            }
        }
    }
}
