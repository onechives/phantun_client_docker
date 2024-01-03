#!/bin/sh

Cip=$(ip addr list eth0 | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')
ip=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
Cnumber=$(echo $ip | awk -F. '{ print $4 }')

Sip=$(awk 'NR==1 {sub(/[[:space:]]+$/, ""); print}' /etc/phantun/p$Cnumber.txt)
Port=$(awk 'NR==2 {sub(/[[:space:]]+$/, ""); print}' /etc/phantun/p$Cnumber.txt)

echo "Container-$Cnumber: Server ip is:$Sip, Port is:$Port"

sysctl -w net.ipv4.ip_forward=1
sysctl -p

iptables -t nat -F
iptables -t nat -A POSTROUTING -o eth0 -s 192.168.200.0/24 -j MASQUERADE
RUST_LOG=info phantun_client --local $Cip:$Port --remote $Sip:$Port  &> /var/log/phantun_client.log &
