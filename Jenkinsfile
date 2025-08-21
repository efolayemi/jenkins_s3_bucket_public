pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['init', 'plan', 'deploy'], description: 'Choose Terraform action')
    }

    environment {
        PLAN_CREATED = false
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
                sh 'terraform fmt -check'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.ACTION == 'plan' || params.ACTION == 'deploy') {
                        sh 'terraform plan -out=tfplan'
                        env.PLAN_CREATED = true
                    }
                }
            }
        }

        stage('Terraform Deploy') {
            steps {
                script {
                    if (params.ACTION == 'deploy' || env.PLAN_CREATED.toBoolean()) {
                        sh 'terraform apply -auto-approve tfplan || terraform apply -auto-approve'
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
