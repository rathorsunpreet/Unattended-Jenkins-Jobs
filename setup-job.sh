#!/bin/bash

# Set the flags to use and other variables
flags=':u:p:h'
usrname=''
psswd=''

# Help Message
usage() {
    echo "Usage: $0 [-u username] [-p password] [-h (help)]" 1>&2
}

exit_on_fail() {
    usage
    exit 1
}

# Cycle through the flags and assign the arguments to appropriate variables
# If no flags or no arguments, then take action
while getopts "${flags}" options; do
    case "${options}" in
        u)
            usrname=${OPTARG}
            ;;
        p)
            psswd=${OPTARG}
            ;;
        h)
            exit_on_fail
            ;;
        :)
            echo "Error: -${OPTARG} requires an argument."
            exit_on_fail
            ;;
        *)
            exit_on_fail
            ;;
    esac
    noargs='true'
done


# Make sure both username and password are present
if [[ -z "${usrname}" || -z "${psswd}" ]]
then
    exit_on_fail
fi

# At this point, both variables are set
echo "Creating a Job"
java -jar jenkins-cli.jar -auth "$usrname":"$psswd" -s http://localhost:8080/ create-job simple-api < simple-api.xml
echo "Running created Job"
java -jar jenkins-cli.jar -auth "$usrname":"$psswd" -s http://localhost:8080/ build -s -v simple-api