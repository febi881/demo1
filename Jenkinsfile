pipeline {
  
  environment {
    registry = "192.168.17.150:5000/aryimg/web1"
    dockerImage = ""
  }
  
  agent any

  stages {
  
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
       //  step([$class: 'kubernetesDeploy', configs: 'myweb.yaml', kubeconfigId: 'mykubeconfig'])
          withKubeConfig([credentialsId: 'mykubeconfig']) {
          sh 'cat deployment.yaml | sed "s/{{BUILD_NUMBER}}/$BUILD_NUMBER/g" | kubectl apply -f -'
          sh 'kubectl apply -f myweb.yaml'
        }
      }
    }

  }

}
