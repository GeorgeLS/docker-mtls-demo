# Socat and Nginx mTLS Proxy Setup

This project demonstrates how to set up a mutual TLS (mTLS) proxy using **Socat** to forward client requests to **Nginx**. The setup is containerized using Docker Compose and supports testing with pre-generated certificates. It also tests direct connection via mTLS support in `curl` and `mapi`
