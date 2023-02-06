#!/bin/ash

iptables-restore forwarding-rules

openfortivpn -c /etc/openfortivpn/conf
