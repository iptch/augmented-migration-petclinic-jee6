# Installing vFunction Controller & Agent on a SpringBoot alpine docker container

This package is a by-example guidelines on how to install and configure vFunction's controller (including agent and viper) on a SpringBoot alpine docker container.

The installation vFunction controller package should be the alpine sudoless installer available from the vFunction portal

1. Extract the package (tar zxvf \<package>) and go into vfunction-controller-in-application-docker directory

2. Login to the [vFunction portal](https://portal.vfunction.com/dashboard) and download the vFunction alpine sudoless installation file (.tgz).

3. Place the downloaded Controller package under ./springboot-alpine/data/controller/

4. Copy your application jar file to ./springboot-alpine/data/application/

5. Login to the vFunction server web UI, create a new application and follow the instructions to fill in the ./springboot-alpine/config/installation.yaml file. (If needed, refer to the vFunction Controller & Agent installation guide found on the portal)

6. Alternatively to the last step, you can automatically create the application on the server while installing the controller. (More details can be found under the "Automatic Server Application Creation" in the controller installation guide)

7. Open and review the Docker file: ./springboot-alpine/Dockerfile

8. Build the Docker file using the command: ```docker build --tag=<image> --force-rm=true springboot-alpine```

9. Run the docker with a command like: 

     ```docker run --name <name> -p 8080:8080 --restart=always -d <image>```

10. Switch back to the vFunction server web UI and verify the controller is connected

### Notes

- The docker files are based on alpine:3.14 with openjdk8. This is arbitrary - you would probably want to expand your own application docker

- The approach in this example is to build the image with a given controller configuration. One could opt to use a more generic approach by not set (and copy) the configuration yaml files during the docker build, but instead - inject a different config file every time a new docker is launched.
  For that you will want to copy the filled ./springboot-alpine/config/installation.yaml and ./springboot-alpine/config/global.yaml configuration files to the machine that will run the docker container, and inject them to the image at run time, like:
     
  ```docker run --name <name> -p 8080:8080 -v <path to your local installation.yaml>:/opt/vfunction/etc/sysconfig/vfunction/installation/instances/default-java/installation.yaml -v <path to your local global.yaml>:/opt/vfunction/etc/sysconfig/vfunction/installation/global.yaml --restart=always -d <image>``` 

  Just make sure to grant the configuration files read/write permissions to all, or at least to the user that will run the docker container.
  You will then have to install the controller at run time by adding the installation command to the startup.sh init script (instead of running upgrade.sh)

- Note the usage of JAVA_TOOL_OPTIONS environment variable in the ./vfunction-controller-in-application-docker/springboot-alpine/files/startup.sh script. This is a cool trick to inject JVM params to the JRE when running a java application. It's added on top of all other JVM or spring-boot params but if your app is not an "uber/fat jar" you will need to edit some JVM params related files instead.

- You can use the configuration option "controller.instance_id" in installation.yaml (uncomment it first) to keep the same instance of controller in the server, even if the docker was restarted (and then the controller was installed again)