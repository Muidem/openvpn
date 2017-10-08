FROM alpine
LABEL maintainer="frankwoodall@gmail.com"

# Add openvpn
RUN apk update && apk add bash openvpn iptables

# Create the volume to read vpn config
VOLUME "/etc/openvpn"

COPY entrypoint.sh /usr/bin

ENTRYPOINT /usr/bin/entrypoint.sh

