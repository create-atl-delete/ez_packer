#!/bin/bash

############ CONFIG ############
SECRET_ID="create.alt.delete"
################################

sudo apt-get update
sudo apt-get install -y sssd sssd-tools krb5-user realmd adcli

# Retrieve the secret value from AWS Secrets Manager
SECRET_STRING=$(aws secretsmanager get-secret-value --secret-id $SECRET_ID --query SecretString --output text)

# Parse the secret string to extract the username and password
USERNAME=$(echo $SECRET_STRING | jq -r ".$USERNAME")
PASSWORD=$(echo $SECRET_STRING | jq -r ".$PASSWORD")
DOMAIN=$(echo $SECRET_STRING | jq -r ".$DOMAIN")

# Join the domain
realm join --user="$USERNAME" --password="$PASSWORD" $DOMAIN

# Verify domain membership
realm list

# Configure SSSD
cat <<EOF | sudo tee /etc/sssd/sssd.conf
[sssd]
domains = $DOMAIN
services = nss, pam

[domain/$DOMAIN]
id_provider = ad
auth_provider = ad
chpass_provider = ad
access_provider = ad
EOF

# Change the permissions of the sssd.conf file
sudo chmod 600 /etc/sssd/sssd.conf

# Restart the SSSD service
sudo systemctl restart sssd