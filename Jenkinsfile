pipeline {
    agent any
    
    environment {
        // Set environment variables if needed
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout code from GitHub
                    checkout([$class: 'GitSCM',
                        branches: [[name: '*/master']],
                        userRemoteConfigs: [[url: 'https://github.com/akash-685603/edureka-project-2.git']]
                    ])
                }
            }
        }

        stage('Compile') {
            steps {
                script {
                    // Compile the code
                    sh 'mvn compile'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run tests
                    sh 'mvn test'
                }
            }
        }

        stage('Package') {
            steps {
                script {
                    // Package the application
                    sh 'mvn package'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dir('/home/akash/Documents/Project2') {
                        // Build Docker image
                        sh 'docker build -t xyztechnologies:latest .'
                    }
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    // Deploy Docker container
                    sh 'docker run -d -p 8081:8080 xyztechnologies:latest'
                }
            }
        }
        
        stage('Debug') {
            steps {
                script {
                    // Debugging information
                    echo 'Pipeline failed. Checking file permissions:'
                    sh 'ls -la /home/akash/Documents/Project2'
                    
                    echo 'Docker status:'
                    sh 'docker info'
                }
            }
        }
    }

    post {
        always {
            // Clean workspace after the build
            cleanWs()
        }
    }
}
