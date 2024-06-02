#!/bin/bash

java -jar jenkins-cli.jar -auth "$1":"$2" -s http://localhost:8080/ create-job simple-api < simple-api.xml
java -jar jenkins-cli.jar -auth "$1":"$2" -s http://localhost:8080/ build simple-api