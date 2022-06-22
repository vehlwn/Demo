#!/bin/bash
iptables -I FORWARD -i %i -o eth0 -s 10.0.150.10/24 -m conntrack --ctstate NEW -j ACCEPT
iptables -I FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -I POSTROUTING -t nat -o eth0 -s 10.0.150.10/24 -j MASQUERADE
