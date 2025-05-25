FROM node:22-slim

# Install system dependencies and security updates
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    git \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user for security
RUN groupadd -r codexuser && useradd -r -g codexuser codexuser

# Set working directory
WORKDIR /app

# Install Codex CLI with specific version for reproducibility
RUN npm install -g @openai/codex@latest

# Copy scripts and set permissions
COPY scripts/ /scripts/
RUN chmod +x /scripts/*.sh

# Create app directory and set ownership
RUN chown -R codexuser:codexuser /app /scripts

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD /scripts/health-check.sh

# Switch to non-root user
USER codexuser

# Set entrypoint
ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["bash"]
