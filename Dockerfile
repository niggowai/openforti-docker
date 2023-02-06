FROM alpine:latest

RUN apk update && apk upgrade && apk add git ppp gcc g++ automake autoconf openssl-dev make iptables

WORKDIR /tmp/

RUN git clone https://github.com/adrienverge/openfortivpn.git

WORKDIR /tmp/openfortivpn/

RUN ./autogen.sh && ./configure --prefix=/usr/local --sysconfdir=/etc && make && make install

RUN rm -r /tmp/*

COPY ./conf-sample /etc/openfortivpn/conf

COPY ./entrypoint.sh /

WORKDIR /

ENTRYPOINT ["./entrypoint.sh"]
