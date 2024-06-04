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
# Could add following flags:
# s - System, currently set to localhost
# c - Connection Port, currently set to 8080
# n - Job name, currently set to simple-api
# f - XML File, currently set to simple-api.xml
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
# Remove the flags "-s -v" if you do not want Console Output redirected to stdout
java -jar jenkins-cli.jar -auth "$usrname":"$psswd" -s http://localhost:8080/ build -s -v simple-api

# Use the following if you know the build number and want to get the Console Output
# Flag "-f" makes the command work like "tails -f"
# Flag "-n N" displays the last N lines
# java -jar jenkins-cli.jar -auth "$usrname":"$psswd" -s http://localhost:8080/ console JOB_NAME JOB_BUILD_NUMBER -f / -n 10 