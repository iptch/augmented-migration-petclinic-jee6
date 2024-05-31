FROM open-liberty:22.0.0.3-full-java11-openj9
MAINTAINER Raviv Halivni

ARG NAME
ARG VERSION
ARG RELEASE

ENV SUMMARY="Open Liberty application wrapper for vFunction Controller."          \
    DESCRIPTION="Open Liberty application wrapper for vFunction Controller."

LABEL summary="$SUMMARY"                                \
      description="$DESCRIPTION"                        \
      io.k8s.description="$DESCRIPTION"                 \
      name="vfunction/$NAME"                            \
      vendor="vFunction"                                \
      version="$VERSION"                                \
      release="$RELEASE"                                \
      maintainer="vfunction.com <raviv@vfunction.com>"

COPY data/controller/vfunction-controller-sudo-less-installation*.tgz /tmp/vfunction-controller-sudo-less-installation.tgz
COPY data/application/* /opt/ol/wlp/usr/servers/defaultServer/dropins/
COPY config/*.yaml /tmp/
COPY files/docker-server.sh /opt/ol/helpers/runtime/docker-server.sh

USER root

RUN cd /tmp/ && tar zxvf /tmp/vfunction-controller-sudo-less-installation.tgz                                       && \
    rm -rf /tmp/vfunction-controller-sudo-less-installation.tgz                                                     && \
    mv /tmp/installation.yaml /tmp/vfunction/etc/sysconfig/vfunction/installation/instances/default-java/                && \
    mv /tmp/global.yaml /tmp/vfunction/etc/sysconfig/vfunction/installation/                                        && \
    bash /tmp/vfunction/opt/vfunction/controller-installation/install.sh -i default-java -n                              && \
    cat /tmp/vfunction/etc/sysconfig/vfunction/agent/instances/default-java/vmargs-examples/liberty >> /opt/ol/wlp/usr/servers/defaultServer/jvm.options && \
    chown -R default:root /opt/ol/                                                                                  && \
    chmod +x /opt/ol/helpers/runtime/docker-server.sh                                                               && \
    chmod -R 777 /tmp/vfunction/

USER 1001
