# Jenkins Pipeline for Spring-PetClinic Project (Deploy to DockerHub)

## Introduction
Pipeline built in Jenkins for the Spring project: ```https://github.com/spring-projects/spring-petclinic```.

## Dockerhub Links
- 'spring-petclinic-hub' repository is where all the runnable images are stored: https://hub.docker.com/repository/docker/tyitzhak/spring-petclinic-hub.
- 'jenkins-docker' repository is where all the containers with jenkins and docker installed are stored: https://hub.docker.com/repository/docker/tyitzhak/jenkins-docker.

## Prerequisites
- Install wget using brew: ```brew install wget```.
- Docker installed.

## Running the Project

1) Clone the project: <br>```git clone https://github.com/talitz/spring-petclinic-jenkins-pipeline.git```

2) CD into the project and provide permissions to the shell running scripts:</br>
- ```cd spring-petclinic-jenkins-pipeline```
- ```chmod 755 *.sh```

3) Run a containerized Docker & Jenkins environemnt using (please provide your password when prompted):</br>
```./start.sh```
</br><b>Note:</b> this takes time, due to the download folder of 'jenkins_home'; it contains all the necessary configurations (job, plugins, etc) for the project to be initialized without manually installing Jenkins.

4) Browse into ```localhost:8080``` and insert the following username & password:
- <b>username:</b> 'admin'.
- <b>password:</b> run the following command in a new terminal and insert the output as a password:</br>
```docker exec jenkins-docker cat /var/jenkins_home/secrets/initialAdminPassword``` 
- Please verify the password for the tyitzhak user in docker hub is the same in Jenkins Credentials Manager - unless you'll get bad credentials error in deploying to dockerhub.

5) Go into the 'spring-petclinic-hub' job, and click on 'Build now'.</br>
Open BlueOcean and follow the pipeline. When it is done (<b>it takes more then 15 minutes, the 'Compile' step takes time</b>) it should look like that:

<img src="https://i.ibb.co/5GjpB5s/Screen-Shot-2020-01-04-at-19-34-58.png" align="center" height="148" width="888" >
</br><b>Note:</b> If one of the stages fails, due to connection/unrelated issues, re-run the stage in Jenkins (shouldn't happen, but just in case).

## How to use the Runnable Docker Image?
The runnable docker image is stored at tyitzhak/spring-petclinic-hub:latest.

Pull the latest petclinic-container image from the dockerhub repository:</br>
```docker pull tyitzhak/spring-petclinic-hub:latest```

Run the container using:</br>
```docker run -d --name petclinic-container -p 8181:8181 tyitzhak/spring-petclinic-hub:latest```

Go into ```localhost:8181``` (it takes about ~10 seconds until the application is up). </br>
Your application is now READY! :)

<img src="https://i.ibb.co/sFsLDvf/Screen-Shot-2020-01-05-at-1-14-53.png" align="center" height="308" width="688" >

You can run the container's shell using:</br>
```docker exec -it petclinic-container sh```

## Terminate the Project
Run ```./terminate.sh```.
