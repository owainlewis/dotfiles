#!/bin/bash

mkdir ~/.oci

openssl genrsa \
-out ~/.oci/oci_api_key.pem 2048

chmod go-rwx ~/.oci/oci_api_key.pem

openssl rsa -pubout \
-in ~/.oci/oci_api_key.pem \
-out ~/.oci/oci_api_key_public.pem

cat > ~/.oci/config <<- EOF
[DEFAULT]
user=?
fingerprint=?
key_file=~/.oci/oci_api_key.pem
tenancy=?
region=us-ashburn-1
EOF
