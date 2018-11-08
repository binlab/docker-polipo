FROM alpine:3.8

LABEL maintainer="Mark <mark.binlab@gmail.com>"

ARG POLIPO_VER=v1.1.1

WORKDIR /tmp

RUN addgroup -S polipo \
    && adduser -S -D -H -s /bin/false -g "Polipo Proxy Service" \
           -G polipo polipo \
    && set -x \
    && apk add --no-cache --virtual .build-deps alpine-sdk \
    && git clone --branch $POLIPO_VER --depth 1 --single-branch \
           https://github.com/binlab/polipo.git polipo \
    && cd /tmp/polipo \
    && make \
    && install polipo /usr/local/bin/ \
    && mkdir -p /var/cache/polipo /usr/share/polipo/www \
    && rm -rf /tmp/polipo \
    && apk del .build-deps

WORKDIR /

USER polipo

EXPOSE 8123

VOLUME /var/cache/polipo

VOLUME /usr/share/polipo/www

ENTRYPOINT ["/usr/local/bin/polipo"]

CMD ["proxyAddress=0.0.0.0", "proxyPort=8123"]
