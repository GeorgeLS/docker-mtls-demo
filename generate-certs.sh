#!/bin/bash

# Directory to store certificates
CERTS_DIR="/app/certs"
mkdir -p "$CERTS_DIR"

# Check if certificates already exist
if [ -f "$CERTS_DIR/server.crt" ] && [ -f "$CERTS_DIR/client.crt" ]; then
  echo "Certificates already exist. Skipping generation."
  exit 0
fi

echo "Generating CA certificate..."
openssl req -x509 -newkey rsa:2048 -keyout "$CERTS_DIR/ca.key" -out "$CERTS_DIR/ca.crt" -days 365 -nodes \
  -subj "/C=US/ST=ExampleState/L=ExampleCity/O=ExampleOrg/OU=ExampleCA/CN=ExampleRootCA"

echo "Generating server certificate..."
openssl req -newkey rsa:2048 -keyout "$CERTS_DIR/server.key" -out "$CERTS_DIR/server.csr" -nodes \
  -subj "/C=US/ST=ExampleState/L=ExampleCity/O=ExampleOrg/OU=ExampleServer/CN=nginx-server"

# Add subjectAltName for hostname matching
echo "subjectAltName=DNS:nginx-server" > "$CERTS_DIR/server.ext"

openssl x509 -req -in "$CERTS_DIR/server.csr" -CA "$CERTS_DIR/ca.crt" -CAkey "$CERTS_DIR/ca.key" -CAcreateserial \
  -out "$CERTS_DIR/server.crt" -days 365 -extfile "$CERTS_DIR/server.ext"

echo "Generating client certificate..."
openssl req -newkey rsa:2048 -keyout "$CERTS_DIR/client.key" -out "$CERTS_DIR/client.csr" -nodes \
  -subj "/C=US/ST=ExampleState/L=ExampleCity/O=ExampleOrg/OU=ExampleClient/CN=ExampleClient"

openssl x509 -req -in "$CERTS_DIR/client.csr" -CA "$CERTS_DIR/ca.crt" -CAkey "$CERTS_DIR/ca.key" -CAcreateserial \
  -out "$CERTS_DIR/client.crt" -days 365

# Set permissions to ensure files are readable by all
chmod 644 "$CERTS_DIR/"*.crt
chmod 644 "$CERTS_DIR/"*.key

# Clean up temporary files
rm "$CERTS_DIR"/*.csr "$CERTS_DIR"/*.ext
echo "Certificates have been generated in '$CERTS_DIR'."
