FROM kylemanna/openvpn

COPY openvpn.conf /etc/openvpn/
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["ovpn_run"]
