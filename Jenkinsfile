pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                dir('/home/akash/Documents/Project2') {
                    script {
                        sh 'docker build -t my-docker-image .'
                    }
                }
            }
        }
    }
}
