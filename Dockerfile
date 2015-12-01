FROM debian:8

MAINTAINER Robert Frånlund <robert.franlund@poweruser.se>

ENV DEBIAN_FRONTEND noninteractive

# Setup repository for Oracle Java 8

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | \
    tee /etc/apt/sources.list.d/webupd8team-java.list
RUN  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections

# Update system
RUN apt-get update && apt-get -y dist-upgrade

# Install
RUN apt-get -y install oracle-java8-installer wget mongodb-server jsvc

# Install Unifi
RUN wget -O /tmp/unifi_sysvinit_all.deb \
    http://www.ubnt.com/downloads/unifi/4.8.6-c922c1b6/unifi_sysvinit_all.deb
RUN dpkg --install /tmp/unifi_sysvinit_all.deb

# Clean up
RUN rm -rf /tmp/unifi_sysvinit_all.deb /var/lib/unifi/*

# Set JAVA_HOME for Oracle Java 8
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Expose ports
EXPOSE 8080/tcp 8443/tcp 8880/tcp 8843/tcp 3478/udp

VOLUME ["/var/lib/unifi"]

WORKDIR /var/lib/unifi

ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar", "start"]

