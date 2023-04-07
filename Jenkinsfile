pipeline {
    agent any

    tools {
        maven "MVN_HOME"
    }

    stages {
        stage('Git checkout') {
            steps {
              
                   git 'https://github.com/SaiRevanth-J/project-02-bank-finacial.git'
            
                }
            }
        stage('maven build') {
              steps {
              
                     sh "mvn install package"
                }
        }
        
        stage('Publish HTML') {
              steps {
                    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/banking_project2/target/surefire-reports', reportFiles: 'index.html', reportName: 'banking_project2-HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                }
        }
        
          stage('Docker build image') {
              steps {
                  
                  sh'sudo docker system prune -af '
                  sh 'sudo docker build -t gururajdockerusername/banking-project:${BUILD_NUMBER}.0 .'
              
                }
            }
                
        stage('Docker login and push') {
              steps {
                   withCredentials([string(credentialsId: 'dockerpasswd', variable: 'dockerpasswd')]) {
                  sh 'sudo docker login -u gururajdockerusername -p ${dockerpasswd} '
                  sh 'sudo docker push gururajdockerusername/banking-project:${BUILD_NUMBER}.0 '
                  }
                }
        }    
                
        stage (' configuring Test-server with terraform & ansible and deploying'){
            steps{

                dir('test-server'){
                sh 'sudo chmod 600 ubuntu-keypair.pem'
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply --auto-approve'
                }
               
            }
        }
                  
    }
}
