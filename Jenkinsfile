pipeline {
    agent any

    environment {
        SCANNER_HOME = tool name: 'SonarScanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
        DOCKER_IMAGE = 'your-docker-image-name' // Replace with your Docker image name
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQubeServer') { // Ensure this matches the name of your SonarQube server
                    sh '''
                        echo "Running SonarQube analysis..."
                        ${SCANNER_HOME}/bin/sonar-scanner -Dsonar.verbose=true
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to your registry
                    // Ensure you have logged in to your Docker registry using 'docker login'
                    sh 'docker push ${DOCKER_IMAGE}'
                }
            }
        }
    }

    post {
        always {
            // Clean up workspace after build
            cleanWs()
        }
        success {
            echo 'Build completed successfully!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
