FROM tomcat:8-jre8
MAINTAINER Raviv Halivni

ARG NAME
ARG VERSION
ARG RELEASE

ENV SUMMARY="Tomcat application wrapper for vFunction Controller."          \
    DESCRIPTION="Tomcat application wrapper for vFunction Controller."

LABEL summary="$SUMMARY"                                \
      description="$DESCRIPTION"                        \
      io.k8s.description="$DESCRIPTION"                 \
      name="vfunction/$NAME"                            \
      vendor="vFunction"                                \
      version="$VERSION"                                \
      release="$RELEASE"                                \
      maintainer="vfunction.com <raviv@vfunction.com>"

COPY data/controller/vfunction-controller-sudo-less-installation*.tgz /tmp/vfunction-controller-sudo-less-installation.tgz
COPY config/*.yaml /tmp/
COPY data/application/*.war /usr/local/tomcat/webapps/
COPY files/health-check.sh /usr/bin/health-check.sh

RUN cd /tmp && tar zxvf /tmp/vfunction-controller-sudo-less-installation.tgz                                                            && \
    rm -rf /tmp/vfunction-controller-sudo-less-installation.tgz                                                                         && \
    mv /tmp/installation.yaml /tmp/vfunction/etc/sysconfig/vfunction/installation/instances/default-java/                               && \
    mv /tmp/global.yaml /tmp/vfunction/etc/sysconfig/vfunction/installation/                                                            && \
    bash /tmp/vfunction/opt/vfunction/controller-installation/install.sh -i default-java -n                                             && \
    echo "cd /tmp/vfunction/opt/vfunction/controller-installation" >> /usr/local/tomcat/bin/setenv.sh                                   && \
    echo "bash restart-controller.sh -i default-java || echo \"Failed to restart the controller\"" >> /usr/local/tomcat/bin/setenv.sh   && \
    cat /tmp/vfunction/etc/sysconfig/vfunction/agent/instances/default-java/vmargs-examples/tomcat >> /usr/local/tomcat/bin/setenv.sh   && \
    chmod +x /usr/bin/health-check.sh                                                                                                   && \
    chmod -R 777 /usr/bin/ /tmp/vfunction

EXPOSE 8080

HEALTHCHECK --interval=5s --retries=12 \
      CMD /usr/bin/health-check.sh
