#!/bin/bash
set -o nounset
set -o errexit

# User input rules must be added in the "my-input" chain. Forward rules must be
# added to "my-forward". IP rate limiting rules must be added in the "my-limit"
# chain.
readonly UNPRIVPORTS="1024:65535"
readonly UNPRIVPORTS_DASH="${UNPRIVPORTS/:/-}"

# wg0
iptables -A my-input -i enp0s5 -p udp --sport "${UNPRIVPORTS}" --dport 56789 -j ACCEPT
iptables -t nat -A PREROUTING -i enp0s5 -p udp --sport "${UNPRIVPORTS}" --dport 53 -j REDIRECT --to-port 56789
for proto in tcp udp
do
    iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o enp0s5 -p "${proto}" -j SNAT \
        --to-source "60.50.40.30:${UNPRIVPORTS_DASH}"
done

# wg0 client input
iptables -A my-input -i wg0 -s 10.0.0.2 -j ACCEPT
# wg0 client forward
iptables -A my-forward -i wg0 -s 10.0.0.2 -j ACCEPT
# ssh limit
iptables -A my-input -p tcp --sport "${UNPRIVPORTS}" --dport 22 -j my-limit
