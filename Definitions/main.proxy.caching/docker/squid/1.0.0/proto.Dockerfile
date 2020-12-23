FROM alpine:3.12.3

RUN apk update \
    && apk add squid-4.13-r0 \
    && apk add curl \
    && apk add openssl \
    && rm -rf /var/cache/apk/*

COPY Scripts/entrypoint.sh /usr/local/bin
COPY Configuration/squid.conf /etc/squid/squid.conf
COPY Configuration/openssl.cnf /etc/squid/ssl_cert/openssl.cnf

RUN chmod 755 /usr/local/bin/entrypoint.sh

RUN mkdir /etc/squid/ssl_cert
COPY openssl.cnf /etc/squid/ssl_cert/openssl.cnf

VOLUME /var/cache/squid
VOLUME /var/log/squid
VOLUME /etc/squid/ssl_cert

EXPOSE {{SERVICE.SQUID.PORTS.CACHING_PORT}}
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]