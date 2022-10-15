#!/bin/bash
set -o nounset
set -o errexit

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
iptables -A my-log-limit-drop -m limit --limit 5/m --limit-burst 10 -j LOG --log-prefix "[IPT LIMIT] "
iptables -A my-log-limit-drop -j DROP

# Helper chain to configure port scan messages
iptables --new-chain my-log-portscan-drop
iptables -A my-log-portscan-drop -m limit --limit 5/m --limit-burst 10 -j LOG --log-prefix "[IPT PORT SCAN] "
iptables -A my-log-portscan-drop -j DROP

# Custom chain for conditional blocking by source IP with rate limiting
iptables --new-chain my-limit
iptables -A my-limit -m recent --set --rsource
iptables -A my-limit -m recent --rcheck --seconds 600 --hitcount 10 --rsource -j my-log-limit-drop
iptables -A my-limit -j ACCEPT

# Unlimited traffic on the loopback interface
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow established sessions
iptables -A INPUT -m conntrack --ctstate INVALID -j my-block
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate INVALID -j my-block
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Port scan protection. Check portscan list and if a packet is in the list,
# update last timestamp and block it.
iptables -A INPUT -m recent --name portscan --update --hitcount 10 --seconds 600 -j my-log-portscan-drop

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
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# Refuse broadcasts
iptables -A INPUT -m addrtype --dst-type BROADCAST -j DROP

readonly CLASS_D_MULTICAST="224.0.0.0/4"
# Refuse Class D multicast addresses
# illegal as a source address
iptables -A INPUT -s "${CLASS_D_MULTICAST}" -j DROP
# Legitimate multicast packets are always UDP packets.
iptables -A INPUT ! -p udp -d "${CLASS_D_MULTICAST}" -j DROP
# allow incoming multicast packets
iptables -A INPUT -p udp -d "${CLASS_D_MULTICAST}" -j ACCEPT

# Custom chain for user INPUT rules
iptables --new-chain my-input
iptables -A INPUT -j my-input
# Port scan (contd). If a packet does not match any rule in the my-input chain,
# add it to the list.
iptables -A INPUT -m recent --name portscan --set
iptables -A INPUT -j my-block

# Custom chain for user FORWARD rules
iptables --new-chain my-forward
iptables -A FORWARD -j my-forward
iptables -A FORWARD -j my-block

/etc/iptables/user-init.sh
