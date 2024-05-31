# Installing vFunction Controller & Agent on a SpringBoot docker container

This package is a by-example guidelines on how to install and configure vFunction's controller (including agent and viper) on a SpringBoot docker container.

The installation vFunction controller package should be the sudoless installer available from the vFunction portal.

1. Extract the package (tar zxvf \<package>) and go into vfunction-controller-in-application-docker directory

2. Login to the [vFunction portal](https://portal.vfunction.com/dashboard) and download the vFunction sudoless installation file (.tgz).
   Note: for alpine based containers - download the alpine-sudoless package.

3. Place the downloaded Controller package under ./sidecar-springboot/data/controller/

4. Copy your application jar file to ./sidecar-springboot/data/application/

5. Login to the vFunction server web UI, create a new application and follow the instructions to fill in the ./springboot/config/installation.yaml file. (If needed, refer to the vFunction Controller & Agent installation guide found on the portal)

6. Alternatively to the last step, you can automatically create the application on the server while installing the controller. (More details can be found under the "Automatic Server Application Creation" in the controller installation guide)

7. Open and review the Docker files: ./sidecar-springboot/Dockerfile-*

8. Build the Docker files using the command (change the <type> placeholder accordingly): ```docker build --tag=<image> --force-rm=true sidecar-springboot -f sidecar-springboot/Docker-<type>```

9. Change the Deployment manifest file at ./sidecar-springboot/manifests/deployment.yaml according to the created docker images

10. Apply the Deployment manifest on your cluster.

11. Switch back to the vFunction server web UI and verify the controller is connected

### Notes

- The docker files are based on centos:7 with openjdk8. This is arbitrary - you would probably want to expand your own application docker

- Note the usage of JAVA_TOOL_OPTIONS environment variable in the ./vfunction-controller-in-application-docker/sidecar-springboot/files/startup-application.sh script. This is a cool trick to inject JVM params to the JRE when running a java application. It's added on top of all other JVM or spring-boot params but if your app is not an "uber/fat jar" you will need to edit some JVM params related files instead.

- You MUST use the configuration option "controller.instance_id" in installation.yaml (uncomment it first) to keep the same instance of controller in the server, even if the docker was restarted (and then the controller was installed again)