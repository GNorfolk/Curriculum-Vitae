import groovy.json.JsonSlurperClassic
pipeline {
  agent any
  parameters {
    choice(name: 'environment', choices: ['Dev', 'Test', 'Prod'], description: "Environment to deploy to.")
  }
  environment {
    Path = "C:\\Program Files\\Python38\\Scripts\\;C:\\Program Files\\Python38\\;D:\\Program Files\\Java\\bin;C:\\Program Files (x86)\\Common Files\\Oracle\\Java\\javapath;C:\\Program Files (x86)\\NVIDIA Corporation\\PhysX\\Common;C:\\Program Files (x86)\\AMD APP\\bin\\x86_64;C:\\Program Files (x86)\\AMD APP\\bin\\x86;C:\\Windows\\system32;C:\\Windows;C:\\Windows\\System32\\Wbem;C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\;C:\\Program Files (x86)\\ATI Technologies\\ATI.ACE\\Core-Static;D:\\Program Files\\Git\\cmd;D:\\Program Files\\Git\\mingw64\\bin;D:\\Program Files\\Git\\usr\\bin;D:\\Program Files\\nodejs\\;C:\\Users\\TheNorfolk\\AppData\\Roaming\\npm;C:\\Users\\TheNorfolk\\AppData\\Local\\Programs\\Microsoft VS Code\\bin;C:\\Users\\TheNorfolk\\AppData\\Local\\atom\\bin;C:\\Users\\TheNorfolk\\terraform_0.12.16_windows_amd64;C:\\Users\\TheNorfolk\\packer_1.4.5_windows_amd64"
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
        dir("${workspace}\\packer") {
          echo 'Running Packer'
          bat("packer build packer.json \
            -var 'aws_access_key=${credsObj.Credentials.AccessKeyId}' \
            -var 'aws_secret_key=${credsObj.Credentials.SecretAccessKey}' \
          ")
        }
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
