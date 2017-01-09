Docker container for the Ubiquiti Unifi controller

You probably need to use --net=host for the auto adoption to work properly.
This is tested using a single Unifi AP Pro. If you test it with different hardware,
please tell me.

You can change the HTTP and HTTPS ports with the environment variables
HTTP_PORT
and HTTPS_PORT

Run the container with
```
docker run -d \
	--net=host \
	-p 8080:8080 \
	-p 8443:8443 \
	-v <data_dir>:/var/lib/unifi \
	rfranlund/unifi:latest
```
