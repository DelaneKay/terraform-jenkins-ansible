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
                sh ("terraform init");
            }
        }
        
        stage('Terraform Action') {
            steps {
                echo "terraform action from the parameter is --> ${action}"
                sh ("terraform ${action} --auto-approve");
            }
        }
    }
}
