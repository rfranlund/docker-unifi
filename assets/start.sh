#!/bin/bash

# Create data directories
mkdir -p /var/lib/unifi/data
mkdir -p /var/lib/unifi/logs

# And some symlinks to get all of the data to the data volume
ln -sf /var/lib/unifi/data /usr/lib/unifi/data
ln -sf /var/lib/unifi/logs /usr/lib/unifi/logs

# Create properties file if it doesn't exist
[ -f /var/lib/unifi/data/system.properties ] || touch /var/lib/unifi/data/system.properties

# Delete port configuration
sed -i -e '/^unifi\.http\.port=.*$/d' /var/lib/unifi/data/system.properties
sed -i -e '/^unifi\.https\.port=.*$/d' /var/lib/unifi/data/system.properties

# Add new config
echo "unifi.http.port=${HTTP_PORT:-8080}" >> /var/lib/unifi/data/system.properties
echo "unifi.https.port=${HTTPS_PORT:-8443}" >> /var/lib/unifi/data/system.properties

/usr/bin/java -Xmx1024M -jar /usr/lib/unifi/lib/ace.jar start
