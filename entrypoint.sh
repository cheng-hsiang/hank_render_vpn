#!/bin/bash
set -e

# Initialize PKI and generate client certificate if not already done
if [ ! -d /etc/openvpn/pki ]; then
    ovpn_genconfig -u udp://$RENDER_EXTERNAL_URL
    echo "yes" | ovpn_initpki
    easyrsa build-client-full client nopass
    ovpn_getclient client > /etc/openvpn/client.ovpn
fi

# Start OpenVPN
ovpn_run &

# Start HTTP server
node /server.js
