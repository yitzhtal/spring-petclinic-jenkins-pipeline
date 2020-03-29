pipeline {
  environment {
    registry = "tyitzhak/spring-petclinic-hub"
    registryCredential = 'docker-hub'
    dockerImage = ''
  }
  agent any
  tools {
    maven 'Maven 3.3.9'
    jdk 'jdk8'
  } 
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/talitz/spring-petclinic-jenkins-pipeline.git'
      }
    }
    stage('Compile') {
       steps {
         sh 'mvn compile' //only compilation of the code
       }
    }
    stage('Test') {
      steps {
        sh '''
        mvn clean install
        ls
        pwd
        ''' 
        //if the code is compiled, we test and package it in its distributable format; run IT and store in local repository
      }
    }

    stage ('Build docker image') {
        steps {
            script {
                docker.build('http://localhost:8082/artifactory/docker/spring-petclinic-hub:latest', 'docker')
            }
        }
    }

    stage ('Push image to Artifactory') {
        steps {
            rtDockerPush(
                serverId: "tal-local-arti",
                image: 'http://localhost:8082/artifactory/docker' + '/spring-petclinic-hub:latest',
                host: "http://172.17.0.3:8080",
                targetRepo: 'docker',
                properties: 'project-name=docker1;status=stable'
            )
        }
    }

    stage ('Publish build info') {
        steps {
            rtPublishBuildInfo (
                serverId: "tal-local-arti"
            )
        }
    }
  }
}
