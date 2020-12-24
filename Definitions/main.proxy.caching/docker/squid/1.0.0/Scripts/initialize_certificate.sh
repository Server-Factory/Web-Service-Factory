#!/bin/sh

set -e

PEM="squid-proxy.pem"
SQUID_LOG_DIR="/var/log/squid"
SQUID_CACHE_DIR="/var/cache/squid"
SSL_CERT_DIR="/etc/squid/ssl_cert"

chown -R squid:squid "$SQUID_CACHE_DIR"
chown -R squid:squid "$SQUID_LOG_DIR"
chown -R squid:squid "$SSL_CERT_DIR"
chmod 755 "$SSL_CERT_DIR"

echo "Checking certificate..."
if ! test -e "$SSL_CERT_DIR"/"$PEM"; then

    echo "No certificate file found. Initializing new certificate..."
    openssl req -new -newkey rsa:2048 \
    -sha256 -days 365 -nodes -x509 -extensions v3_ca \
    -keyout "$SSL_CERT_DIR"/"$PEM"  \
    -out "$SSL_CERT_DIR"/"$PEM" \
    -config "$SSL_CERT_DIR"/openssl.cnf \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" # TODO: <--- replace with server data
    /usr/lib/squid/ssl_crtd -c -s /var/lib/ssl_db
    chown squid:squid -R /var/lib/ssl_db
else

    echo "Found existing certificate at $SSL_CERT_DIR/$PEM"
fi