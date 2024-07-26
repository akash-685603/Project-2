pipeline {
    agent any

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
                    dir('/home/akash/Documents/Project2/Project2@tmp/') {
                        sh 'docker build -t akashsingh/xyztechnologies:1.0 .'
                    }
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh '''
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push akashsingh/xyztechnologies:1.0
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
                    sh 'docker run -d -p 8081:8080 akashsingh/xyztechnologies:1.0'
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
