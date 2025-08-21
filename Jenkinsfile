pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['init', 'deploy'], description: 'Choose Terraform action')
    }

    // Stage 1: Checkout Code (CI)
    stages {
        stage('Checkout GitHub Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/efolayemi/jenkins_s3_bucket_public.git'
                // Checkout the current repo automatically; no hardcoding
                checkout scm
            }
        }

        // Stage 2: Terraform Init (CI)
        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'my-aws-credentials', region: 'eu-west-2') {
                    sh 'terraform init'
                }
            }
        }

        // Stage 3: Terraform Plan (CI)
        stage('Terraform Plan') {
            steps {
                script {
                    if (params.ACTION == 'plan') {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        // Stage 4: Terraform Deploy (CD)
        stage('Terraform Deploy') {
            steps {
                script {
                    if (params.ACTION == 'deploy') {
                        withAWS(credentials: 'my-aws-credentials', region: 'eu-west-2') {
                            sh 'terraform-deploy auto-approve'
                    }
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
