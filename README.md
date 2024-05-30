# Augmented Migration: petclinic-jee6 example

This is a version of https://github.com/Jakarta-EE-Petclinic/petclinic-jee6 adapted to run in a Docker container.
The Dockerfile is based on https://github.com/ovanekem/docker-jboss-7.1.1.final

Hint: Tests removed because of issues with the dependencies and the build

## Run locally
1. Download JBoss 7.1.1.Final (jboss-as-7.1.1.Final.zip) from http://www.jboss.org/jbossas/downloads
2. Download JDK 7u79 from https://www.oracle.com/java/technologies/javase/javase7-archive-downloads.html
3. Install the JDK and set the JAVA_HOME environment variable to the installation directory
4. On Windows: Add the bin folder of the JDK installation directory to the path variable
5. Unzip JBoss 7.1.1.Final and run `jboss-as-7.1.1.Final/bin/standalone.sh` or `jboss-as-7.1.1.Final/bin/standalone.bat` on Windows  
6. In the folder `petclinic-jee6`, run:
```bash
./mvnw -Dmaven.test.skip -Dhttps.protocols=TLSv1.2 clean install
```
7. Copy the file `petclinic-jee6/target/jee6-petclinic-1.0-SNAPSHOT.war` to `jboss-as-7.1.1.Final/standalone/deployments/`
8. Open http://localhost:8080/jee6-petclinic-1.0-SNAPSHOT/ in a browser

## Run with Docker
Prerequisites: 
- Make sure you have Git LFS installed (https://git-lfs.com/)
- Files need to be checked out with the LF line ending (Linux) instead of CRLF (Windows)

1. Download jboss-as-7.1.1.Final.zip from http://www.jboss.org/jbossas/downloads and place it in the same folder as the Dockerfile
2. Download jdk-7u79-linux-x64.rpm from https://www.oracle.com/java/technologies/javase/javase7-archive-downloads.html and place it in the same folder as the Dockerfile (you'll need an Oracle Account)
3. Build:
```bash
docker build -t petclinic-jee6 .
```
4. Run:
```bash
docker run -it -p 8080:8080 -p 9990:9990 petclinic-jee6
```
5. Open http://localhost:8080/jee6-petclinic-1.0-SNAPSHOT/ in a browser

