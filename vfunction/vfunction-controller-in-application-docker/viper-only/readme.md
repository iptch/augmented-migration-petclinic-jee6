# Installing vFunction Controller (with viper only) on a docker container

This package is a by-example guidelines on how to install and configure vFunction's controller (including only a viper) on a docker container.

The installation vFunction controller package should be the sudoless installer available from the vFunction portal.

1. Extract the package (tar zxvf \<package>) and go into vfunction-controller-in-application-docker directory

2. Login to the [vFunction portal](https://portal.vfunction.com/dashboard) and download the vFunction sudoless installation file (.tgz).
   Note: for alpine based containers - download the alpine-sudoless package.

3. Place the downloaded Controller package under ./viper-only/data/controller/

4. Copy your application jar file to ./viper-only/data/application/

5. Login to the vFunction server web UI, create a new application and follow the instructions to fill in the ./viper-only/config/installation.yaml file. (If needed, refer to the vFunction Controller & Agent installation guide found on the portal)

6. Alternatively to the last step, you can automatically create the application on the server while installing the controller. (More details can be found under the "Automatic Server Application Creation" in the controller installation guide)

7. Open and review the Docker file: ./viper-only/Dockerfile

8. Build the Docker file using the command: ```docker build --tag=<image> --force-rm=true viper-only```

9. Run the docker with a command like: 

     ```docker run --name <name> -p 8080:8080 --restart=always -d <image>```

10. Switch back to the vFunction server web UI and verify the controller is connected

### Notes

- The docker files are based on centos:7. This is arbitrary - you would probably want to expand your own base docker

- The approach in this example is to build the image with a given controller configuration. One could opt to use a more generic approach by not set (and copy) the configuration yaml files during the docker build, but instead - inject a different config file every time a new docker is launched.
  For that you will want to copy the filled ./viper-only/config/installation.yaml and ./viper-only/config/global.yaml configuration files to the machine that will run the docker container, and inject them to the image at run time, like:
     
  ```docker run --name <name> -p 8080:8080 -v <path to your local installation.yaml>:/opt/vfunction/etc/sysconfig/vfunction/installation/instances/default-java/installation.yaml -v <path to your local global.yaml>:/opt/vfunction/etc/sysconfig/vfunction/installation/global.yaml --restart=always -d <image>``` 

  Just make sure to grant the configuration files read/write permissions to all, or at least to the user that will run the docker container. 

- You can use the configuration option "controller.instance_id" in installation.yaml (uncomment it first) to keep the same instance of controller in the server, even if the docker was restarted (and then the controller was installed again)