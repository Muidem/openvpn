#!/usr/bin/env bash

# Start vpn

# Start iptables
# Allow loopback device (internal communication)
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow all local traffic.
iptables -A INPUT -s 172.17.0.1/24 -j ACCEPT
iptables -A OUTPUT -d 172.17.0.1/24 -j ACCEPT

# Allow DNS
iptables -A OUTPUT -p udp -o eth0 --dport 53 -j ACCEPT
iptables -A INPUT -p udp -i eth0 --sport 53 -j ACCEPT

# Allow VPN establishment
iptables -A OUTPUT -p udp --dport 1194 -j ACCEPT
iptables -A INPUT -p udp --sport 1194 -j ACCEPT

# Allow all TUN connections
iptables -A OUTPUT -o vpn_tun -j ACCEPT
iptables -A INPUT -i vpn_tun -j ACCEPT

# And drop the rest
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

openvpn --config /etc/openvpn/vpn.conf

