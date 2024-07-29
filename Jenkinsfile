pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'akash7575/xyztechnologies:1.0'
        DOCKER_CREDENTIALS_ID = 'akash7575'
        REGISTRY = 'index.docker.io/v1'
        DEPLOYMENT_PORT = '8081'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', 
                          branches: [[name: '*/master']],
                          userRemoteConfigs: [[url: 'https://github.com/akash-685603/Project-2.git']]
                ])
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
                    echo 'Building Docker image...'
                    def buildCmd = "docker build --build-arg DEPLOYMENT_PORT=${DEPLOYMENT_PORT} -t ${DOCKER_IMAGE} ."
                    sh returnStdout: true, script: buildCmd
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo "Pushing Docker image ${DOCKER_IMAGE}..."
                    try {
                        docker.withRegistry("https://${REGISTRY}", DOCKER_CREDENTIALS_ID) {
                            docker.image("${DOCKER_IMAGE}").push('latest')
                            docker.image("${DOCKER_IMAGE}").push('1.0')
                        }
                    } catch (Exception e) {
                        echo "Failed to push Docker image: ${e.message}"
                        currentBuild.result = 'FAILURE'
                        throw e
                    }
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    sh """
                    docker run -d -p ${DEPLOYMENT_PORT}:${DEPLOYMENT_PORT} --name xyztechnologies ${DOCKER_IMAGE}
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
