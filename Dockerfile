# Use a lightweight Python image
FROM python:3.9-slim

# Install necessary system packages
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy only requirements.txt first to leverage Docker cache
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . .

# Expose the port
EXPOSE 9090

# Set environment variables (for Railway to provide PORT dynamically)
ENV PORT=9090

# Run the application
CMD ["python", "app.py"]
