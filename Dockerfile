# Use Python 3.13 slim image as base
FROM python:3.13-slim as base

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# Set working directory
WORKDIR /app

# Copy project files
COPY pyproject.toml uv.lock ./
COPY src/ ./src/
COPY tests/ ./tests/

# Install dependencies and build the project
RUN uv sync --frozen --no-install-project --no-dev

# Production stage
FROM python:3.13-slim as production

# Install uv in production image
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# Create non-root user
RUN useradd --create-home --shell /bin/bash app \
    && mkdir -p /app \
    && chown -R app:app /app

# Set working directory
WORKDIR /app

# Copy installed packages from builder stage
COPY --from=base /root/.local/ /root/.local/

# Copy project files
COPY --from=base /app /app

# Change to non-root user
USER app

# Expose port (if your app serves HTTP)
EXPOSE 8000

# Default command
CMD ["uv", "run", "python", "-c", "from template import hello; print(hello())"]
