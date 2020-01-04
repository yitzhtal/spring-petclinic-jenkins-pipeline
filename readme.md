# Jenkins Pipeline for Spring-PetClinic Project

## Introduction
Pipeline built in Jenkins for the Spring project: ```https://github.com/spring-projects/spring-petclinic```.

## Dockerhub Links
- 'spring-petclinic-hub' repository is where all the runnable images are stored: https://hub.docker.com/repository/docker/tyitzhak/spring-petclinic-hub.
- 'jenkins-docker' repository is where all the containers with jenkins and docker installed are stored: https://hub.docker.com/repository/docker/tyitzhak/jenkins-docker.

## Running the Project

1) Clone the project: ```git clone https://github.com/talitz/spring-petclinic-jenkins-pipeline.git```.

2) CD into the project and provide permissions to the shell running scripts:</br>
- ```cd spring-petclinic-jenkins-pipeline```
- ```chmod 755 *.sh```

3) Run a containerized Docker & Jenkins environemnt using (please provide your password when prompted):</br>
```sudo ./start.sh```
</br><b>Note:</b> this takes time, due to the download folder of 'jenkins_home'; it contains all the necessary configurations (job, plugins, etc) for the project to be initialized without manually installing Jenkins.

3) Browse into ```localhost:8080``` and insert the following username & password:
- <b>username:</b> 'admin'.
- <b>password:</b> run ```docker exec jenkins-docker cat /var/jenkins_home/secrets/initialAdminPassword``` in the Terminal and insert the output you see.

4) Go into the 'spring-petclinic-hub' job, and click on 'Build now'.</br>
Open BlueOcean and follow the pipeline. When it is done it should look like that:

<img src="https://i.ibb.co/5GjpB5s/Screen-Shot-2020-01-04-at-19-34-58.png" align="center" height="148" width="888" >

## How to use the Runnable Docker Image?
The runnable docker image is stored at tyitzhak/spring-petclinic-hub:latest.

Just run it using the following command:</br>
```docker run -d --name petclinic-container -p 8087:8087 tyitzhak/spring-petclinic-hub:latest```

## Terminate the Project
Run ```sudo ./terminate.sh```.
