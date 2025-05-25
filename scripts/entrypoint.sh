#!/bin/bash
set -euo pipefail

# Validate environment variables
if [[ -z "${OPENAI_API_KEY:-}" ]]; then
    echo "ERROR: OPENAI_API_KEY environment variable is required"
    exit 1
fi

# Set proper permissions for workspace
if [[ -d "/app/workspace" ]]; then
    chown -R codexuser:codexuser /app/workspace
fi

# Log startup
echo "$(date): Starting Codex CLI container"
echo "Node version: $(node --version)"
echo "NPM version: $(npm --version)"

# Check Codex CLI installation
if command -v codex &> /dev/null; then
    echo "Codex CLI is installed and ready"
else
    echo "ERROR: Codex CLI not found"
    exit 1
fi

# Execute the command
exec "$@"
