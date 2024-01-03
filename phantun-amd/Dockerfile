FROM alpine:latest

RUN apk update \
  && apk upgrade \
  && apk add --no-cache iptables \
  && rm -rf /var/cache/apk/*

COPY entrypoint.sh /usr/sbin/
COPY phantun.sh /usr/sbin/
COPY phantun_client /usr/sbin/

ENTRYPOINT ["/usr/sbin/entrypoint.sh"]