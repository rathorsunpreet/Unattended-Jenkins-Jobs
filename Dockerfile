FROM jenkins/jenkins:lts

# Stop Jenkins from running the setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

# Setup the suggested plugins using the list from 
# https://github.com/jenkinsci/jenkins/blob/master/core/src/main/resources/jenkins/install/platform-plugins.json
COPY plugins.yaml /usr/share/jenkins/ref/plugins.yaml
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.yaml

# Use Configuration as Code YAML file to setup Jenkins
COPY casc.yaml /var/jenkins_home/casc.yaml

# Copy Jenkins-CLI into $JENKINS_HOME
COPY jenkins-cli.jar /var/jenkins_home/jenkins-cli.jar

# Copy a Jenkins job into the $JENKINS_HOME folder
COPY simple-api.xml /var/jenkins_home/simple-api.xml

# Copy shell script into $JENKINS_HOME folder
copy setup-job.sh /var/jenkins_home/setup-job.sh
