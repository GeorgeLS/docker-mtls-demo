# Base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose application port
EXPOSE 8000

# Command to run the app with Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]