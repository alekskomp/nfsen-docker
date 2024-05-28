FROM debian:12

ENV TZ="Europe/Moscow"
ENV NFSEN_VERSION="1.3.11"

ARG AUTH_USER="admin"
ARG AUTH_PASS="netflow"

EXPOSE 80

EXPOSE 9995

ADD https://github.com/phaag/nfsen/archive/refs/tags/v.$NFSEN_VERSION.tar.gz /tmp/

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends --no-install-suggests nfdump rrdtool libmailtools-perl librrds-perl libsocket6-perl libio-socket-ssl-perl php php-fpm nginx apache2-utils && \
    apt-get remove --purge -y apache2 && \
    apt-get clean -y && \
    mkdir -p /opt/data /opt/nfsen/src /opt/app && \
    sed -i 's/^;date.timezone =/date.timezone \= \"Europe\/Moscow\"/g' /etc/php/8.2/fpm/php.ini && \
    htpasswd -c -b /etc/nginx/.htpasswd $AUTH_USER $AUTH_PASS && \
    mv /tmp/v.$NFSEN_VERSION.tar.gz /opt/nfsen/src/ && \
    cd /opt/nfsen/src && \
    tar xf v.$NFSEN_VERSION.tar.gz

COPY nfsen-dist.conf /opt/nfsen/src/nfsen-v.$NFSEN_VERSION/etc/nfsen-dist.conf

COPY nginx_default /etc/nginx/sites-available/default

COPY run.sh /opt/app/

RUN chmod +x /opt/app/run.sh

CMD ["/opt/app/run.sh"]

