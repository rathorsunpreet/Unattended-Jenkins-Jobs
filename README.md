# Unattended-Jenkins-Jobs

Unattended-Jenkins-Jobs utilizes Docker Image of Jenkins and does unattended setup of Jenkins. This is achieved by using Jenkins Configuration As Code Plugin, i.e, all the post-install steps are done using a YAML file with the plugins to be installed read from a separate file.

After the Jenkins setup is operational, the user can perform an interactive bash connection to the container in order to either create / run a job via the provided "jenkins-cli.jar", no GUI required. As an example, "simple-api.xml" job is already provided with "setup-job.sh" to create and build the job.

User setup is done at run-time via the two following methods:
1. Using the "--env" flag with "docker run" command.
2. Using the "--env-file" flag with "docker run" to specify the file to use.

To setup the user, the following two Environment Variables are used:
1. JENKINS_ADMIN_ID
2. JENKINS_ADMIN_PASSWORD

Demo / Explanation: https://www.youtube.com/watch?v=s715EUHGxIs

## Important Files
The following table list the files with a short description of what they do:
| File Name | Short Description |
| --------- | ----------------- |
| casc.yaml | Contains Jenkins Configuration ranging from User Access Setup to Plugins File Location / Name and more |
| Dockerfile | Setup information for the image |
| jenkins-cli.jar | Allows to use Jenkins via Terminal |
| plugins.yaml(.txt) | List of Plugins to Install, suggested or otherwise |
| setup-job.sh | Contains commands to create and run a job |
| simple-api.xml | Jenkins Job Configuration as an XML file |

## Installation

Download the [Github Repo]() and unzip it.

## Usage

```cmd
# To build the image
# First cd into the downloaded github repo location
docker -t unattended-jenkins .

# Execution using "docker run --env"
docker run --rm -p 8080:8080 \
--env JENKINS_ADMIN_ID=<username> \
--env JENKINS_ADMIN_PASSWORD=<password> unattended-jenkins

# Execution using "docker run --env-file"
docker run --rm -p 8080:8080 \
--env-file=.env unattended-jenkins

# To run the provided shell script
# The provided username and password can be different from
# the ones used in "docker run" command but the user needs to
# have the correct permissions.
./setup-job.sh -u <username> -p <password>
```

## Notes

Wait until Jenkins is fully operational before using "jenkins-cli".

## License

[MIT](https://choosealicense.com/licenses/mit/)