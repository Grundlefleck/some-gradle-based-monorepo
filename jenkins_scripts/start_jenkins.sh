#!/usr/bin/env bash

# Steps to get a minimal Jenkins running
# Adapted from: https://batmat.net/2018/09/07/how-to-run-and-upgrade-jenkins-using-the-official-docker-image/

docker volume create jenkins-data
docker run --name jenkins-local --detach -p 50000:50000 -p 8080:8080 -v jenkins-data:/var/jenkins_home jenkins/jenkins
docker exec jenkins-local bash -c 'cat $JENKINS_HOME/secrets/initialAdminPassword'