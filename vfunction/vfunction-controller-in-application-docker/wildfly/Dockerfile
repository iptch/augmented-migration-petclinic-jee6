FROM jboss/wildfly:25.0.0.Final

USER root

ENV WILDFLY_BASE /opt/jboss/wildfly

# following are the versions of wildfly-common and jboss-logmanager in Wildfly 25. Your versions
# may vary depending on jboss/wildfly version used.
ARG WILDFLY_COMMON_VER=1.5.4
ARG JBOSS_LOGMANAGER_VER=2.1.18.GA

COPY data/controller/vfunction-controller-sudo-less-installation*.tgz /tmp/vfunction-controller-sudo-less-installation.tgz
COPY data/application/*.war /opt/jboss/wildfly/standalone/deployments/
COPY config/*.yaml /tmp/

RUN cd /tmp/ && tar zxvf /tmp/vfunction-controller-sudo-less-installation.tgz                                                                                                               && \
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

USER jboss
