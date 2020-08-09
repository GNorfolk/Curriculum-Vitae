import groovy.json.JsonSlurperClassic
pipeline {
  agent any
  parameters {
    choice(name: 'environment', choices: ['Dev', 'Test', 'Prod'], description: "Environment to deploy to.")
  }
  environment {
    PATH = "/usr/local/opt/helm@2/bin:/Users/norfolgx/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin"
  }
  stages {
    stage('Setup') {
      steps {
        script {
          echo "Prerequisite Setup"
          bat "mkdir tmp"
          echo "Declaring Variables"
          switch (environment) {
            case 'Dev':
              role = "arn:aws:iam::103348857345:role/Admin"
              session = "Curriculum-Vitae-${environment}-Deployment"
              region = "eu-west-1"
              break
            case 'Test':
              role = "arn:aws:iam::103348857345:role/Admin"
              session = "Curriculum-Vitae-${environment}-Deployment"
              region = "eu-west-1"
              break
            case 'Prod':
              role = "arn:aws:iam::103348857345:role/Admin"
              session = "Curriculum-Vitae-${environment}-Deployment"
              region = "eu-west-1"
              break
          }
          echo "Assuming Role"
          bat("aws sts assume-role \
            --role-arn ${role} \
            --role-session-name ${session} \
            --region ${region} \
            > tmp/assume-role-output.json")
          echo "Preparing Credentials"
          credsJson = readFile("${workspace}/tmp/assume-role-output.json")
          credsObj = new groovy.json.JsonSlurperClassic().parseText(credsJson)
        }
      }
    }
    stage('Build') {
      steps {
        dir("${workspace}") {
          echo 'Holder for CV build.'
        }
      }
    }
    stage('Deploy') {
      steps {
        dir("${workspace}/terraform/deploys/${environment}") {
          echo "Initialising Terraform"
          sh("terraform init -input=false -no-color \
            -var access_key=${credsObj.Credentials.AccessKeyId} \
            -var secret_key=${credsObj.Credentials.SecretAccessKey} \
            -var token=${credsObj.Credentials.SessionToken}")
            echo "Deploying Terraform"
          sh("terraform apply -auto-approve -no-color \
            -var access_key=${credsObj.Credentials.AccessKeyId} \
            -var secret_key=${credsObj.Credentials.SecretAccessKey} \
            -var token=${credsObj.Credentials.SessionToken}")
        }
      }
    }
  }
  post {
    cleanup {
      script {
        echo 'End of Jenkinsfile'
        sh("rm -rf tmp")
      }
    }
  }
}
