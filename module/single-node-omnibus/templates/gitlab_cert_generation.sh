#!/bin/sh

sudo mkdir /etc/gitlab/ssl
sudo chmod 700 /etc/gitlab/ssl

echo "Create Self Signed Certs for Encryption"
echo "Generating SSL for $(uname -n)"
commonname=$(uname -n)
country=${cert_org_country}
state=${cert_org_state}
locality=${cert_org_locality}
organization=${cert_org}
organizationalunit=${cert_org_unit}
email=${cert_email}
password=$(openssl rand -base64 32)

#Generate a key
openssl genrsa -des3 -passout pass:$password -out /etc/gitlab/ssl/$commonname.key 2048 -noout

#Remove passphrase from the key. Comment the line out to keep the passphrase
echo "Removing passphrase from key"
openssl rsa -in /etc/gitlab/ssl/$commonname.key -passin pass:$password -out /etc/gitlab/ssl/$commonname.key

#Create the request
echo "Creating CSR"
openssl req -new -key /etc/gitlab/ssl/$commonname.key -out /etc/gitlab/ssl/$commonname.csr -passin pass:$password \
    -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"

#Create Cert
echo "Creating Cert"
openssl x509 -req -days 365 -in /etc/gitlab/ssl/$commonname.csr -signkey /etc/gitlab/ssl/$commonname.key -out /etc/gitlab/ssl/$commonname.crt

# Clean up CSR
echo "Clean up CSR"
sudo rm -rf /etc/gitlab/ssl/$commonname.csr

#Set permissions
echo "Setting Permissions"
sudo chmod 0400 /etc/gitlab/ssl/$commonname.*
sudo chown git:git /etc/gitlab/ssl/$commonname.*