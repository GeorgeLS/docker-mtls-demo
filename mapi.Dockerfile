FROM alpine:latest

# Install required utilities
RUN apk add --no-cache curl bash

# Set the Mayhem URL environment variable
ENV MAYHEM_URL=https://app.mayhem.security

# Download and install the mapi CLI
RUN curl -Lo /usr/local/bin/mapi $MAYHEM_URL/cli/mapi/linux-musl/latest/mapi && chmod +x /usr/local/bin/mapi

# Set the working directory
WORKDIR /app

# Default command
CMD ["/bin/bash"]
