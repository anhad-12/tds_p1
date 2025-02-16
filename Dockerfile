FROM python:3.12-slim-bookworm

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates

# Download and install uv
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin:$PATH"

# Set up the application directory
WORKDIR /app

# Copy all application files
COPY . /app

# Install dependencies (if required)
RUN pip install -r /app/requirements.txt

# Explicitly set the correct binary path and use `sh -c`
CMD ["uv", "run", "app.py"]