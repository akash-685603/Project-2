pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'akashsingh/xyztechnologies:1.0'
        DOCKER_CREDENTIALS_ID = 'dockerhub'
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
                    dir('/home/akash/Documents/Project2') {
                        echo 'Current directory:'
                        sh 'pwd'
                        echo 'Listing files:'
                        sh 'ls -la'
                        echo 'Building Docker image...'
                        sh 'docker build -t ${DOCKER_IMAGE} .'
                    }
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        echo 'Pushing Docker image to DockerHub...'
                        sh '''
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push ${DOCKER_IMAGE}
                        '''
                    }
                }
            }
        }
        
        stage('Deploy Docker Container') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    echo 'Deploying Docker container...'
                    sh '''
                    docker stop xyztechnologies || true
                    docker rm xyztechnologies || true
                    docker run -d --name xyztechnologies -p 8081:8080 ${DOCKER_IMAGE}
                    '''
                }
            }
        }
        
        stage('Debug') {
            when {
                expression { currentBuild.result == 'FAILURE' }
            }
            steps {
                echo 'Pipeline failed. Checking file permissions:'
                sh 'ls -la /home/akash/Documents/Project2'
                echo 'Docker status:'
                sh 'docker info'
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}
