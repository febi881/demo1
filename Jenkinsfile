pipeline {
  
  environment {
    registry = "192.168.17.150:5000/aryimg/web1"
    dockerImage = ""
  }

  stages {
  
    agent {  docker { image 'golang' } }
           
    stage('Checkout Source') {
      steps {
        git 'https://github.com/febi881/demo1.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( "" ) {
            dockerImage.push()
          }
        }
      }
    }

    stage('Deploy App') {
      steps {
        script {
          kubernetesDeploy(configs: "myweb.yaml", kubeconfigId: "mykubeconfig")
        }
      }
    }

  }

}
