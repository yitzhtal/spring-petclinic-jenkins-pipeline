
# Download the jenkins_home folder, it contains all the configuration needed.

wget -O jenkins_home.zip https://dl.dropboxusercontent.com/s/o13g19ok5zi4ega/jenkins_home.zip?dl=0 && \
sudo unzip -X -o jenkins_home.zip                                  && \
rm jenkins_home.zip

sudo chown -R "$(whoami)" "$(find $(pwd)/jenkins_home -maxdepth 0 -type d)"

# Run the jenkins-docker container, with mount to jenkins_home; on port 8080
# Relative path was not used in Mount; therefore find command was used to find
# the full path of the jenkins_home folder
docker run --name jenkins-docker \
 -u root -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock \
 -v "$(find $(pwd)/jenkins_home -maxdepth 0 -type d)":/var/jenkins_home \
 tyitzhak/jenkins-docker:latest
