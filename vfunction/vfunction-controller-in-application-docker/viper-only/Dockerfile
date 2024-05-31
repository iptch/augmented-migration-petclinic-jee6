FROM centos:7
MAINTAINER Raviv Halivni

ARG NAME
ARG VERSION
ARG RELEASE

ENV SUMMARY="Wrapper for vFunction Controller (with only viper)."          \
    DESCRIPTION="Wrapper for vFunction Controller (with only viper)"

LABEL summary="$SUMMARY"                                \
      description="$DESCRIPTION"                        \
      io.k8s.description="$DESCRIPTION"                 \
      name="vfunction/$NAME"                            \
      vendor="vFunction"                                \
      version="$VERSION"                                \
      release="$RELEASE"                                \
      maintainer="vfunction.com <raviv@vfunction.com>"

RUN yum -y update-minimal --security --sec-severity=Important --sec-severity=Critical       && \
    adduser -l -u "1500" "appuser"                                                          && \
    mkdir -p /opt/application/lib

COPY data/controller/vfunction-controller-sudo-less-installation*.tgz /tmp/vfunction-controller-sudo-less-installation.tgz
COPY config/*.yaml /tmp/
COPY data/application/* /opt/application/lib/
COPY files/startup.sh /usr/bin/startup.sh
COPY files/health-check.sh /usr/bin/health-check.sh

RUN cd /tmp && tar zxvf /tmp/vfunction-controller-sudo-less-installation.tgz                                && \
    rm -rf /tmp/vfunction-controller-sudo-less-installation.tgz                                             && \
    mv /tmp/installation.yaml /tmp/vfunction/etc/sysconfig/vfunction/installation/instances/default-java/   && \
    mv /tmp/global.yaml /tmp/vfunction/etc/sysconfig/vfunction/installation/                                && \
    bash /tmp/vfunction/opt/vfunction/controller-installation/install.sh -i default-java -v -n              && \
    chmod +x /usr/bin/health-check.sh                                                                       && \
    chmod +x /usr/bin/startup.sh                                                                            && \
    chmod -R 777 /usr/bin/ /tmp/vfunction                                                                   && \
    chmod +x /opt/application/lib/*

HEALTHCHECK --interval=5s --retries=12 \
      CMD /usr/bin/health-check.sh

USER 1500

ENTRYPOINT ["/bin/sh"]
CMD ["/usr/bin/startup.sh"]