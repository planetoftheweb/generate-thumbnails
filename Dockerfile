FROM alpine:latest

RUN apk --update add git

RUN echo "${ALPINE_MIRROR}/edge/main" >> /etc/apk/repositories

RUN apk add --no-cache --repository="http://dl-cdn.alpinelinux.org/alpine/v3.8/main/" nodejs-current npm

RUN node --version

RUN apk add --no-cache --upgrade bash

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
