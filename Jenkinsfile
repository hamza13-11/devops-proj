node {
  stage('SCM') {
    checkout scm
  }
  stage('SonarQube Analysis') {
    def scannerHome = tool 'SonarScanner';
    withSonarQubeEnv() {
      sh "${scannerHome}/bin/sonar-scanner"
    }
  }
  stage('Build Docker Image') {
    def dockerImage
    def dockerRegistry = 'docker.io'
    def dockerImageName = 'your-dockerhub-username/your-image-name'
    def dockerImageTag = 'latest'

    script {
      dockerImage = docker.build("${dockerRegistry}/${dockerImageName}:${dockerImageTag}")
    }
  }
  stage('Push Docker Image') {
    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials-id', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
      sh "docker login -u ${DOCKER_USER} -p ${DOCKER_PASS} ${dockerRegistry}"
      sh "docker push ${dockerRegistry}/${dockerImageName}:${dockerImageTag}"
    }
  }
}
