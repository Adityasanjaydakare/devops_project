pipeline {
    agent any

    environment {
        IMAGE_NAME = "devsecops-app"
        DOCKER_TAG = "latest"
        AWS_DEFAULT_REGION = "ap-south-1"
    }

    stages {

        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                dir('app') {
                    sh '''
                        node -v
                        npm -v
                        npm install
                    '''
                }
            }
        }

        stage('Trivy File Scan') {
            steps {
                sh 'trivy fs app'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${DOCKER_TAG} .'
            }
        }

        stage('Trivy Image Scan') {
            steps {
                sh 'trivy image ${IMAGE_NAME}:${DOCKER_TAG}'
            }
        }

        stage('Terraform Infra Provision (EC2)') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    dir('terraform') {
                        sh '''
                            terraform init
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }

        stage('Monitoring Setup (Prometheus + Grafana)') {
            steps {
                sh '''
                    cd ansible
                    ansible-playbook -i inventory playbook.yml
                '''
            }
        }
    }

    post {
        success {
            emailext(
                subject: "✅ Jenkins Pipeline SUCCESS - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
                <h2>Pipeline Status: SUCCESS</h2>
                <p><b>Project:</b> ${env.JOB_NAME}</p>
                <p><b>Build Number:</b> ${env.BUILD_NUMBER}</p>
                <p><b>Build URL:</b> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                <br>
                <p>All stages completed successfully 🚀</p>
                """,
                mimeType: 'text/html',
                to: "your-email@gmail.com"
            )
        }

        failure {
            emailext(
                subject: "❌ Jenkins Pipeline FAILED - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
                <h2>Pipeline Status: FAILED</h2>
                <p><b>Project:</b> ${env.JOB_NAME}</p>
                <p><b>Build Number:</b> ${env.BUILD_NUMBER}</p>
                <p><b>Build URL:</b> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                <br>
                <p>Please check Jenkins console logs for errors ⚠️</p>
                """,
                mimeType: 'text/html',
                to: "adakare64@gmail.com"
            )
        }
    }
}
