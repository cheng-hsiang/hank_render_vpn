FROM kylemanna/openvpn

# Install Node.js and npm
RUN apt-get update && apt-get install -y nodejs npm

# Copy OpenVPN configuration files
COPY openvpn.conf /etc/openvpn/
COPY entrypoint.sh /entrypoint.sh

# Copy server.js for HTTP server
COPY server.js /server.js

RUN chmod +x /entrypoint.sh

# Install Express
RUN npm install express

# Expose the HTTP server port
EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]