FROM quay.io/wildfly/wildfly:28.0.0.Final-jdk11

USER root

ENV WILDFLY_BASE /opt/jboss/wildfly

# following are the versions of wildfly-common and jboss-logmanager in Wildfly 25. Your versions
# may vary depending on jboss/wildfly version used.
ARG WILDFLY_COMMON_VER=1.6.0
ARG JBOSS_LOGMANAGER_VER=2.1.19

COPY vfunction/vfunction-controller-sudo-less-installation*.tgz /tmp/vfunction-controller-sudo-less-installation.tgz
COPY vfunction/vfunction-controller-in-application-docker/wildfly/config/*.yaml /tmp/

RUN cd /tmp/ && gunzip -c vfunction-controller-sudo-less-installation.tgz | tar zxvf -                                                                                                               && \
  rm -rf /tmp/vfunction-controller-sudo-less-installation.tgz                                                                                                                               && \
  mv /tmp/installation.yaml /tmp/vfunction/etc/sysconfig/vfunction/installation/instances/default-java/                                                                                     && \
  mv /tmp/global.yaml /tmp/vfunction/etc/sysconfig/vfunction/installation/                                                                                                                  && \
  bash /tmp/vfunction/opt/vfunction/controller-installation/install.sh -i default-java -n                                                                                                   && \
  echo "bash /tmp/vfunction/opt/vfunction/controller-installation/restart-controller.sh -i default-java echo \"Failed to restart the controller\"" >> $WILDFLY_BASE/bin/standalone.conf     && \
  cat /tmp/vfunction/etc/sysconfig/vfunction/agent/instances/default-java/vmargs-examples/wildfly >> $WILDFLY_BASE/bin/standalone.conf                                                      && \
  chmod -R 777 /tmp/vfunction                                                                                                                                                               && \
  chown -R jboss:root /tmp/vfunction/                                                                                                                                                       && \
  sed -i "s~<your-wildfly-base-path>~$WILDFLY_BASE~g" $WILDFLY_BASE/bin/standalone.conf                                                                                                     && \
  sed -i "s~wildfly-common-<version>.jar~wildfly-common-${WILDFLY_COMMON_VER}.Final.jar~g" $WILDFLY_BASE/bin/standalone.conf                                                                && \
  sed -i "s~jboss-logmanager-<version>.jar~jboss-logmanager-${JBOSS_LOGMANAGER_VER}.Final.jar~g" $WILDFLY_BASE/bin/standalone.conf

#RUN chown jboss:jboss $WILDFLY_BASE/usr

USER jboss

# Add and build petclinic application
RUN mkdir -p $WILDFLY_BASE/src
ADD petclinic-jakartaee-main $WILDFLY_BASE/src
RUN cd $WILDFLY_BASE/src && ./mvnw -Dmaven.test.skip clean install
RUN ls $WILDFLY_BASE/src/target/ && mv $WILDFLY_BASE/src/target/petclinic-jakartaee.war $WILDFLY_BASE/standalone/deployments/

# Expose ports
EXPOSE 8080
EXPOSE 9990

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b=0.0.0.0", "-bmanagement=0.0.0.0"]
