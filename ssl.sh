#!/bin/sh

rm -rf ssl && mkdir ssl
cd ssl

openssl genrsa -out rootCA.key 2048
# openssl req -new -key rootCA.key -out rootCA.csr -subj "/C=KR/ST=Seoul/L=Seoul/O=Example Company/OU=IT Department/CN=example.com"
openssl req -new -key rootCA.key -out rootCA.csr -subj "/C=KR/ST=Seoul/L=Seoul/O=localhost/OU=localhost/CN=localhost"
openssl x509 -req -in rootCA.csr -signkey rootCA.key -out rootCA.crt

openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr -subj "/C=KR/ST=Seoul/L=Seoul/O=localhost/OU=localhost/CN=localhost"
openssl x509 -req -in server.csr -CA rootCA.crt -CAkey rootca.key -CAcreateserial -out server.crt

cd ..
