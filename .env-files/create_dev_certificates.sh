#!/bin/sh
set -e

# generate CA private key
openssl genrsa -out ca.key 2048

# self signed CA certificate
openssl req -x509 -new -nodes -subj "/commonName=ca" \
       -key ca.key -sha256 -days 1024 -out ca.crt


openssl genrsa -out certificate.key 2048
openssl req -new -key certificate.key -out certificate.csr
openssl x509 -req -in certificate.csr -CA ca.crt -CAkey ca.key \
        -out certificate.crt -days 500 -sha256 \
        -CAcreateserial -CAserial ca.srl

rm certificate.csr ca.srl
