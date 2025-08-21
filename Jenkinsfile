pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['init', 'apply'], description: 'Choose Terraform action')
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the current repo automatically; no need to hardcode URL
                checkout scm
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                withAWS(credentials: 'fola-aws-credentials', region: 'eu-west-2') {
                    sh 'terraform init'

                    script {
                        if (params.ACTION == 'apply') {
                            sh 'terraform apply -auto-approve'
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
