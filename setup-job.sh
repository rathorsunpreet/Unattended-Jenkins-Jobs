#!/bin/bash

if [ "$#" -eq 0 ]
then
    echo "No arguments supplied!"
    exit 1
elif [ "$#" -ne 2 ]
then
    echo "Incorrect count of arguments!"
    exit 1
else
    echo "Creating a Job"
    java -jar jenkins-cli.jar -auth "$1":"$2" -s http://localhost:8080/ create-job simple-api < simple-api.xml
    echo "Running created Job"
    java -jar jenkins-cli.jar -auth "$1":"$2" -s http://localhost:8080/ build simple-api
fi