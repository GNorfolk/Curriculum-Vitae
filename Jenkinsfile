pipeline {
  agent any
  parameters {
    choice(name: 'environment', choices: ['Infra', 'Dev'])
  }
  stages {
    stage('Setup') {
      steps {
        echo 'Setup...'
        switch(environment) {
          case 'Dev':
            role = ""
            session = "Curriculum-Vitae-${environment}-Deployment"
            region = "eu-west-1"
          case 'Test':
            role = ""
            session = "Curriculum-Vitae-${environment}-Deployment"
            region = "eu-west-1"
          case 'Prod':
            role = ""
            session = "Curriculum-Vitae-${environment}-Deployment"
            region = "eu-west-1"
        }
      }
    }
    stage('Build') {
      steps {
        echo 'Building...'
      }
    }
    stage('Test') {
      steps {
        echo 'Testing...'
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying...'
      }
    }
  }
  post {
    success {
      script {
        echo 'Great Success...'
      }
    }
  }
}
