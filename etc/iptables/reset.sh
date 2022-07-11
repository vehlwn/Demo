#!/bin/bash
iptables -t filter --flush
iptables -t nat --flush
iptables -t mangle --flush
iptables -t raw --flush
iptables -t security --flush

iptables -t filter --delete-chain
iptables -t nat --delete-chain
iptables -t mangle --delete-chain
iptables -t raw --delete-chain
iptables -t security --delete-chain

iptables -t filter --policy INPUT ACCEPT
iptables -t filter --policy FORWARD ACCEPT
iptables -t filter --policy OUTPUT ACCEPT
iptables -t nat --policy PREROUTING ACCEPT
iptables -t nat --policy OUTPUT ACCEPT
iptables -t nat --policy POSTROUTING ACCEPT
iptables -t mangle --policy PREROUTING ACCEPT
iptables -t mangle --policy OUTPUT ACCEPT
