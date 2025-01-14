# Use a minimal base image
FROM alpine:latest

# Install necessary tools
RUN apk add --no-cache openssl socat

# Set up working directory
WORKDIR /app

# Expose HTTP and Socat ports
EXPOSE 12345 443

# Default command
CMD ["sh"]
