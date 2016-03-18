FROM dayzleaper/docker-debian-jre8:latest

MAINTAINER Robert Frånlund <robert.franlund@poweruser.se>

ENV DEBIAN_FRONTEND noninteractive

# Update
RUN apt-get update

# Install
RUN apt-get -y install wget mongodb-server jsvc

# Install Unifi
RUN wget -O /tmp/unifi_sysvinit_all.deb \
    https://www.ubnt.com/downloads/unifi/4.9.2-5554d2b2/unifi_sysvinit_all.deb
RUN dpkg --install /tmp/unifi_sysvinit_all.deb

# Clean up
RUN rm -rf /tmp/unifi_sysvinit_all.deb /var/lib/unifi/*

# Expose ports
EXPOSE 8080/tcp 8443/tcp 8880/tcp 8843/tcp 3478/udp

# Add start script
ADD assets/start.sh /start.sh

VOLUME ["/var/lib/unifi"]

WORKDIR /var/lib/unifi

CMD ["/start.sh"]
