pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['init', 'plan', 'deploy'], description: 'Choose Terraform action')
    }

    stages {
        stage('Checkout GitHub Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/efolayemi/jenkins_s3_bucket_public.git'
            }
        }

        stage('Terraform Validation & Linting') {
            steps {
                sh 'terraform validate'
                sh 'terraform fmt -check || echo "Formatting issues found"'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            when {
                expression { params.ACTION == 'plan' || params.ACTION == 'deploy' }
            }
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Deploy') {
            when {
                expression { params.ACTION == 'deploy' }
            }
            steps {
                sh 'terraform apply -auto-approve tfplan || terraform apply -auto-approve'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
