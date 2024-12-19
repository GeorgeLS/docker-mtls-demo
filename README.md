# Socat and Nginx mTLS Proxy Setup

This project demonstrates how to set up a mutual TLS (mTLS) proxy using **Socat** to forward client requests to **Nginx**. The setup is containerized using Docker Compose and supports testing with pre-generated certificates.

---

## Features
- **mTLS enforcement**: Socat validates client certificates and forwards valid requests to Nginx.
- **Nginx backend**: Nginx requires certificates for all incoming connections.
- **Self-signed certificates**: Certificates are generated dynamically for testing purposes.
- **Curl-based testing**: A dedicated service (`socat-tester`/`curl-tester`) validates the behavior of the proxy setup.

---

## Requirements
- **Docker**: Ensure Docker is installed on your machine.
- **Docker Compose**: Required for orchestrating multiple services.

---

## Directory Structure
```
project-root/
├── certs/                # Directory to store generated certificates
├── generate-certs.sh     # Script to generate self-signed certificates
├── nginx.conf            # Nginx configuration file
├── Dockerfile            # Dockerfile for custom services
├── docker-compose.yml    # Docker Compose configuration file
└── index.html            # Sample HTML file served by Nginx
```

---

## Setup

### Start the Services
Start all services using Docker Compose:
```bash
docker-compose up --build
```

---

## Services Overview

### 1. **Cert-Gen**
- Generates self-signed certificates required for mTLS.
- Stores certificates in the `certs/` directory.

### 2. **Socat-Server**
- Acts as a proxy server listening on port `12345`.
- Terminates mTLS for incoming client connections.
- Forwards validated requests to the Nginx backend.

### 3. **Nginx-Server**
- Serves requests forwarded by Socat.
- Enforces mTLS for all incoming connections.
- Hosts a sample HTML page (`index.html`).

### 4. **Socat-Tester**
- Simulates clients connecting to the Socat proxy.

## 5.  **curl-tester**
- Simulates clients connecting directly to Nginx (with certs).

---

## Configuration

### Nginx Configuration
Refer to `nginx.conf` for the complete Nginx setup, which enforces mTLS for all connections and serves the `index.html` file.

### Socat Command
Refer to the `docker-compose.yml` file for the `socat-server` configuration, which includes the commands used for setting up Socat as a proxy.

---

## Debugging

### Common Issues
- **Missing Certificates**: Ensure the `certs/` directory contains the required files (`server.crt`, `server.key`, `client.crt`, `client.key`, `ca.crt`).
- **Permission Errors**: Ensure certificate and key files have the correct permissions.
- **Hostname Mismatch**: Ensure the `commonName` or `subjectAltName` in the certificates matches the hostname (e.g., `localhost`).

### Logs
View logs for individual services by using `docker-compose logs` with the appropriate service name.

---

## License
This project is licensed under the MIT License. See `LICENSE` for more details.
