pipeline {
  environment {
    registry = "tyitzhak/spring-petclinic-hub"
    registryCredential = 'docker-hub'
    dockerImage = ''
  }
  agent any
  tools {
    maven 'maven3.6'
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
    
    /*
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
    stage('Building Image') {
      steps{
        script {
          dockerImage = docker.build registry + ":latest"
        }
      }
    }
    stage('Deploy Image to DockerHub') {
      steps{
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
            }
        }
      }
    }
    */

    stage ('Artifactory configuration') {
        steps {
            // specify Artifactory server
            rtServer (
                id: "ARTIFACTORY_SERVER",
                url: "http://artifactory:8081/artifactory",
                credentialsId: 'admin.jfrog'
            )
           // specify the repositories to be used for deploying the artifacts in the Artifactory
            rtMavenDeployer (
                id: "MAVEN_DEPLOYER",
                serverId: "ARTIFACTORY_SERVER",
                releaseRepo: "spring-petclinic-release-local",
                snapshotRepo: "spring-petclinic-snapshot-local"
            )
            // defines the dependencies resolution details
            //rtMavenResolver (
            //    id: "MAVEN_RESOLVER",
            //    serverId: "ARTIFACTORY_SERVER",
            //    releaseRepo: "spring-petclinic-release",
            //    snapshotRepo: "spring-petclinic-snapshot"
            //)
        }
    }
    stage ('Build & Upload Artifact') {
        steps {
            rtMavenRun (
                tool: "maven3.6", 
                pom: 'pom.xml',
                goals: 'clean install',
                deployerId: "MAVEN_DEPLOYER",
                resolverId: "MAVEN_RESOLVER"
            )
        }
    }
    stage ('Publish build info') {
        steps {
            rtPublishBuildInfo (
                serverId: "ARTIFACTORY_SERVER"
            )
        }
    }
  }
}