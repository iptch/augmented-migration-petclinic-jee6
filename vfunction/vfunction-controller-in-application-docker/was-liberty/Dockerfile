FROM websphere-liberty:kernel
MAINTAINER Raviv Halivni

ARG NAME
ARG VERSION
ARG RELEASE

ENV SUMMARY="WebSphere Liberty application wrapper for vFunction Controller."          \
    DESCRIPTION="WebSphere Liberty application wrapper for vFunction Controller."

LABEL summary="$SUMMARY"                                \
      description="$DESCRIPTION"                        \
      io.k8s.description="$DESCRIPTION"                 \
      name="vfunction/$NAME"                            \
      vendor="vFunction"                                \
      version="$VERSION"                                \
      release="$RELEASE"                                \
      maintainer="vfunction.com <raviv@vfunction.com>"

USER root

COPY data/controller/vfunction-controller-sudo-less-installation*.tgz /tmp/vfunction-controller-sudo-less-installation.tgz
COPY data/application/* /config/dropins/
COPY files/server.xml /config/

COPY config/*.yaml /tmp/
COPY files/startup.sh /usr/bin/startup.sh
COPY files/health-check.sh /usr/bin/health-check.sh

RUN apt-get update && apt-get install -y wget                                                                       && \
    features.sh                                                                                                     && \
    configure.sh                                                                                                    && \
    cd /tmp/ && tar zxvf /tmp/vfunction-controller-sudo-less-installation.tgz                                       && \
    rm -rf /tmp/vfunction-controller-sudo-less-installation.tgz                                                     && \
    mv /tmp/installation.yaml /tmp/vfunction/etc/sysconfig/vfunction/installation/instances/default-java/                && \
    mv /tmp/global.yaml /tmp/vfunction/etc/sysconfig/vfunction/installation/                                        && \
    bash /tmp/vfunction/opt/vfunction/controller-installation/install.sh -i default-java -n                              && \
    cat /tmp/vfunction/etc/sysconfig/vfunction/agent/instances/default-java/vmargs-examples/liberty >> /opt/ibm/wlp/usr/servers/defaultServer/jvm.options && \
    chown -R 1001:0 /config                                                                                         && \
    chmod +x /usr/bin/health-check.sh /usr/bin/startup.sh                                                           && \
    chmod -R 777 /usr/bin/ /tmp/vfunction/

USER 1001

ENTRYPOINT ["/usr/bin/startup.sh"]
CMD ["/opt/ibm/wlp/bin/server", "run", "defaultServer"]
