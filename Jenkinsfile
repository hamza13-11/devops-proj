pipeline {
    agent any

    tools {
        // Specify the SonarScanner tool
        sonarQube 'SonarScanner'
    }

    environment {
        // Define environment variables
        scannerHome = tool 'SonarScanner'
    }

    stages {
        stage('SCM') {
            steps {
                // Checkout the code from the repository
                checkout scm
            }
        }
        stage('SonarQube Analysis') {
            steps {
                // Run SonarQube analysis
                withSonarQubeEnv('SonarQube') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                // Build the Docker image
                script {
                    def imageName = "react-app:latest"
                    sh "docker build -t ${imageName} ."
                }
            }
        }
    }

    post {
        always {
            // Cleanup actions or notifications can be added here
            echo 'Pipeline execution finished.'
        }
    }
}
