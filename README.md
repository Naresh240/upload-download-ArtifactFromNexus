# spring-boot-hello

## Pre-requisites:
    - Install Java
    - Install Git
    - Install Maven
    - Install Nexus
## Install Java:
    yum install java-1.8.0-openjdk-devel -y
## Install Git:
    yum install git -y
## Install Apache-Maven:
    wget https://mirrors.estointernet.in/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
    tar xvzf apache-maven-3.6.3-bin.tar.gz

    vi /etc/profile.d/maven.sh
    --------------------------------------------
    export MAVEN_HOME=/opt/apache-maven-3.6.3
    export PATH=$PATH:$MAVEN_HOME/bin
    --------------------------------------------

    source /etc/profile.d/maven.sh
    mvn -version
## Steps to push artifacts to nexus:
1. We need to modify with nexus url inside pom.xml
    Inside url we need to replace repository name 
    
        <distributionManagement>
            <snapshotRepository>
                <id>nexus-snapshots</id>
                <url>http://100.26.240.37:8081/repository/maven-snapshots/</url>
            </snapshotRepository>
            <repository>
                <id>nexus-releases</id>
                <url>http://100.26.240.37:8081/repository/maven-releases/</url>
            </repository>
        </distributionManagement>
2. The credentials of the server have to be defined in the global Maven setting.xml:

        <server>
            <id>nexus-snapshots</id>
            <username>admin</username>
            <password>admin123</password>
          </server>
        <server>
            <id>nexus-releases</id>
            <username>admin</username>
            <password>admin123</password>
          </server>
        </servers>
3. Run below command to run and deploy to nexus repository
    
        mvn clean install
        mvn deploy
Now go and check whether artifact uploaded into nexus repository
## Download artifacts from nexus repository
Run shell script with run time variables
  
    Run time variables are,
      - groupid
      - artifactid
      - version
    Optional parameters:
      - classifier
      - type
Syntax:      

    sh get_artifact_from_nexus.sh groupid artifactid version
Command to Run:
  
    sh get_artifact_from_nexus.sh org.springframework gs-spring-boot 0.1.0
