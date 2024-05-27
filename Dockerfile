FROM jboss/base:latest

# Define JBOSS admin user and password
ENV ADMIN_USER admin
ENV ADMIN_PASSWORD welcome1

# Root user to install software
USER root

COPY jdk-7u79-linux-x64.rpm /opt/
RUN rpm -i /opt/jdk-7u79-linux-x64.rpm && rm /opt/jdk-7u79-linux-x64.rpm

# Switch back to jboss user
USER jboss

ENV JAVA_HOME /usr/java/jdk1.7.0_79

# Add and unzip jboss
COPY jboss-as-7.1.1.Final.zip /opt/jboss
RUN cd $HOME \
    && unzip jboss-as-7.1.1.Final.zip \
    && rm jboss-as-7.1.1.Final.zip

# Add admin user
RUN /opt/jboss/jboss-as-7.1.1.Final/bin/add-user.sh --silent=true $ADMIN_USER $ADMIN_PASSWORD

# Add and build petclinic application
RUN mkdir -p $HOME/src
ADD petclinic-jee6 /opt/jboss/src
RUN cd /opt/jboss/src && ./mvnw -Dmaven.test.skip -Dhttps.protocols=TLSv1.2 clean install
RUN ls $HOME/src/target/ && mv $HOME/src/target/jee6-petclinic-1.0-SNAPSHOT.war $HOME/jboss-as-7.1.1.Final/standalone/deployments/

# Expose ports   
EXPOSE 8080
EXPOSE 9990

CMD ["/opt/jboss/jboss-as-7.1.1.Final/bin/standalone.sh", "-b=0.0.0.0", "-bmanagement=0.0.0.0"]
