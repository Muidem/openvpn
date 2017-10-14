FROM alpine
LABEL maintainer="frankwoodall@gmail.com"

RUN apk update && apk add bash openvpn

VOLUME /config

CMD openvpn --config /config/vpn.conf
