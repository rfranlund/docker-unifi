# docker-unifi
Container for the Ubiquiti Unifi controller

Run with

docker run -d --net=host -p 8080 -p 8443 -v <data_dir>:/var/lib/unifi -v /etc/localtime:/etc/localtime:ro dayzleaper/unifi-4.8.6
