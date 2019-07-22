#!/bin/sh

sudo chmod 700 /etc/gitlab/ssl

echo "Create Self Signed Certs for Encryption"
echo "Generating SSL for $(uname -n)"
commonname=$(uname -n)
country=${CERT_ORGANIZATION_COUNTRY}
state=${CERT_ORGANIZATION_STATE}
locality=${CERT_ORGANIZATION_LOCATION}
organization=${CERT_ORGANIZATION}
organizationalunit=${CERT_ORGANIZATION_UNIT}
email=${CERT_EMAIL}
password=$(openssl rand -base64 32)

#Generate a key
openssl genrsa -des3 -passout pass:$password -out /etc/gitlab/ssl/gitlab-selfsigned.key 2048 -noout

#Remove passphrase from the key. Comment the line out to keep the passphrase
echo "Removing passphrase from key"
openssl rsa -in /etc/gitlab/ssl/gitlab-selfsigned-selfsigned.key -passin pass:$password -out /etc/gitlab/ssl/gitlab-selfsigned-selfsigned.key

#Create the request
echo "Creating CSR"
openssl req -new -key /etc/gitlab/ssl/gitlab-selfsigned.key -out /etc/gitlab/ssl/gitlab-selfsigned.csr -passin pass:$password \
    -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"

#Create Cert
echo "Creating Cert"
openssl x509 -req -days 365 -in /etc/gitlab/ssl/gitlab-selfsigned.csr -signkey /etc/gitlab/ssl/gitlab-selfsigned.key -out /etc/gitlab/ssl/gitlab-selfsigned.crt

# Clean up CSR
echo "Clean up CSR"
sudo rm -rf /etc/gitlab/ssl/gitlab-selfsigned.csr

#Set permissions
echo "Setting Permissions"
sudo chmod 0400 /etc/gitlab/ssl/gitlab-selfsigned.*
sudo chown gitlab:gitlab /etc/gitlab/ssl/gitlab-selfsigned.*
