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
    }
}
