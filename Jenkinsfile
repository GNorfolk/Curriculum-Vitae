pipeline {
  agent any
  parameters {
    choice(name: 'environment', choices: ['Dev', 'Test', 'Prod'])
  }
  stages {
    stage('Setup') {
      steps {
        echo 'Setup...'
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
    stage('Deploy') {
      steps {
        dir("${workspace}\\terraform\\deploys\\${environment}") {
          echo "Initialising Terraform"
          bat("terraform init -input=false -no-color \
            -var access_key=${credsObj.Credentials.AccessKeyId} \
            -var secret_key=${credsObj.Credentials.SecretAccessKey} \
            -var token=${credsObj.Credentials.SessionToken}")
            echo "Deploying Terraform"
          bat("terraform apply -auto-approve -no-color \
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
        bat("""rmdir "${workspace}\\tmp" /S /Q""")
      }
    }
  }
}
