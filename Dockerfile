# Alpine Linux with OpenJDK JRE
FROM openjdk:8-jre-alpine

EXPOSE 8087

# copy WAR into image
COPY target/spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar /spring-petclinic.jar

# run application with this command line 
ENTRYPOINT ["java","-jar","/spring-petclinic.jar"]