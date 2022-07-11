#!/bin/bash
set -o nounset

/etc/iptables/reset.sh

# Set the default policy
iptables --policy INPUT DROP
iptables --policy OUTPUT ACCEPT
iptables --policy FORWARD DROP

# Custom chain to unconditionally log and block packtes
iptables --new-chain my-block
iptables -A my-block -m limit --limit 5/m --limit-burst 10 -j LOG --log-prefix "[IPT BLOCK] "
iptables -A my-block -j DROP

# Helper chain to configure LIMIT messages
iptables --new-chain my-log-limit-drop
iptables -A my-log-limit-drop -m limit --limit 3/m --limit-burst 10 -j LOG --log-prefix "[IPT LIMIT] "
iptables -A my-log-limit-drop -j DROP

# Custom chain for conditional blocking by source IP with rate limiting
iptables --new-chain my-limit
iptables -A my-limit -m conntrack --ctstate NEW -m recent \
	--update --seconds 30 --hitcount 6 --rsource -j my-log-limit-drop
iptables -A my-limit -m recent --set -j ACCEPT

# Unlimited traffic on the loopback interface
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow established sessions
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -m conntrack --ctstate INVALID -j my-block
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate INVALID -j my-block

# Four ICMP control and status messages (RFC 792) need to pass through the
# firewall: Source Quench (deprecated by RFC 6633), Parameter Problem, incoming
# Destination Unreachable, and outgoing Destination Unreachable of subtype
# Fragmentation Needed. Four other ICMP message types are optional: Echo
# Request, Echo Reply, other outgoing Destination Unreachable subtypes, and
# Time Exceeded. Other message types can be ignored, to be filtered out by the
# default policy.

# An ICMP message will never be fragmented under normal circumstances
iptables -A INPUT --fragment -p icmp -j my-block
# Parameter Problem Message (type 12)
iptables -A INPUT -p icmp --icmp-type parameter-problem -j ACCEPT
# Destination Unreachable Message (type 3)
iptables -A INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT
# Time Exceeded Message (type 11)
iptables -A INPUT -p icmp --icmp-type time-exceeded -j ACCEPT
# Incoming ping echo message (Type 8)
# iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# Custom chain for user INPUT rules
iptables --new-chain my-input
iptables -A INPUT -j my-input
iptables -A INPUT -j my-block

# Custom chain for user FORWARD rules
iptables --new-chain my-forward
iptables -A FORWARD -j my-forward
iptables -A FORWARD -j my-block

# User input rules must be added in the "my-input" chain. Forward rules must be
# added to "my-forward". IP rate limiting rules must be added in the "my-limit"
# chain.
readonly UNPRIVPORTS="1024:65535"

# wg0
iptables -A my-input -i enp0s5 -p udp --sport "${UNPRIVPORTS}" --dport 56789 -j ACCEPT
iptables -t nat -A PREROUTING -i enp0s5 -p udp --sport "${UNPRIVPORTS}" --dport 53 -j REDIRECT --to-port 56789
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o enp0s5 -j MASQUERADE
# wg0 client input
iptables -A my-input -i wg0 -s 10.0.0.2 -j ACCEPT
# wg0 client forward
iptables -A my-forward -i wg0 -s 10.0.0.2 -j ACCEPT
# ssh limit
iptables -A my-input -p tcp --sport "${UNPRIVPORTS}" --dport 22 -j my-limit
