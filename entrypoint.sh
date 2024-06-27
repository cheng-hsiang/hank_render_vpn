#!/bin/bash

# 初始化OpenVPN的PKI
ovpn_initpki

# 生成服务端证书
easyrsa build-ca nopass
easyrsa gen-req server nopass
easyrsa sign-req server server
easyrsa gen-dh
openvpn --genkey --secret /etc/openvpn/ta.key
cp pki/ca.crt pki/private/ca.key pki/issued/server.crt pki/private/server.key pki/dh.pem /etc/openvpn

# 生成客户端证书
CLIENTNAME="client"
easyrsa build-client-full $CLIENTNAME nopass
ovpn_getclient $CLIENTNAME > /etc/openvpn/$CLIENTNAME.ovpn

# 创建一个简单的HTTP服务器来提供客户端配置文件
nohup python3 -m http.server --directory /etc/openvpn 8080 &

# 启动OpenVPN服务器
ovpn_run
