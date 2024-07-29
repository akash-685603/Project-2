pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'akashsingh/xyztechnologies:1.0'
        DOCKER_CREDENTIALS_ID = 'dockerhub'
        REGISTRY = 'docker.io' // Replace with your Docker registry if different
        DEPLOYMENT_PORT = '8081'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/akash-685603/edureka-project-2.git'
            }
        }

        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("https://${REGISTRY}", DOCKER_CREDENTIALS_ID) {
                        docker.image(DOCKER_IMAGE).push('latest')
                    }
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    sh """
                    docker run -d -p ${DEPLOYMENT_PORT}:8081 --name xyztechnologies ${DOCKER_IMAGE}
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            sh 'docker stop xyztechnologies || true'
            sh 'docker rm xyztechnologies || true'
            sh 'docker rmi ${DOCKER_IMAGE} || true'
        }

        failure {
            echo 'Build failed. Please check the logs for more details.'
        }

        success {
            echo 'Build succeeded. The Docker container is deployed.'
        }
    }
}
