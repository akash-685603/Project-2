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
                    dir('/home/akash/Documents/Project2') {
                        sh 'docker build -t my-app-image .'
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
                    sh 'docker run -d -p 8081:8080 my-app-image'
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
