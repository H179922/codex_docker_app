# codex_docker_app

# OpenAI Codex CLI Docker Setup

This repository demonstrates how to run the OpenAI Codex CLI inside a Docker container with your local Windows folder mounted for development. It uses an `.env` file to securely provide your API key and includes `.gitignore` and `.dockerignore` to keep secrets and unnecessary files out of version control.

## Overview

This enhanced setup provides a robust containerized environment for running OpenAI Codex CLI on Debian-based systems with proper security configurations, health monitoring, and development workflow support.

## Features

### 🔒 Security First
- Non-root user execution with proper permission handling
- Security options and capability restrictions  
- Read-only filesystem configurations where applicable
- Comprehensive input validation and error handling

### 🚀 Production Ready
- Health checks for container monitoring
- Restart policies for high availability
- Version pinning for reproducible deployments
- Proper logging and error handling mechanisms

### 🔧 Development Integration
- Environment-based configuration using .env files
- Workspace volume mounting for persistent development
- Interactive shell access for debugging
- Container lifecycle management

### 📊 Monitoring & Management
- Optional Portainer agent integration
- Watchtower compatibility for automatic updates
- Comprehensive health checks and status monitoring

## Quick Start

### Prerequisites
- Docker Engine 20.10+
- Docker Compose 2.0+
- Valid OpenAI API key

## Project Structure

```
/opt/codex-app/
├── docker-compose.yml
├── .env.example
├── .gitignore
├── .dockerignore
├── Dockerfile
├── scripts/
│   ├── entrypoint.sh
│   └── health-check.sh
└── README.md
```

### Installation

```bash
# Clone the repository
git clone <your-repo-url> /opt/codex-app
cd /opt/codex-app

# Configure environment
cp .env.example .env
# Edit .env with your OpenAI API key
```

### Configuration

Create your `.env` file based on the example:

```bash
# OpenAI Configuration
OPENAI_API_KEY=sk-your-api-key-here
OPENAI_ORG_ID=org-your-org-id-here

# Application Settings
LOG_LEVEL=info
MAX_TOKENS=2048
TEMPERATURE=0.7

# Security Settings
CODEX_USER_ID=1000
CODEX_GROUP_ID=1000

# Optional: Monitoring
ENABLE_MONITORING=false
```

### Usage Commands

```bash
# Build and start the container
docker compose build
docker compose up -d

# Verify container health and status
docker compose ps
docker compose logs codex

# Interactive session for development
docker compose exec codex bash

# One-off command execution for code generation
docker compose run --rm codex codex "Generate a Python script for data processing"

# Generate specific code files
docker compose run --rm codex codex "Create a FastAPI application with authentication"

# Batch processing with workspace mounting
docker compose run --rm -v $(pwd)/projects:/app/workspace codex bash -c "
  for prompt in /app/workspace/*.txt; do
    codex \"$(cat $prompt)\" > \"/app/workspace/generated_$(basename $prompt .txt).py\"
  done
"

# Enable monitoring with Portainer integration
docker compose --profile monitoring up -d

# Code review and optimization
docker compose run --rm codex codex "Review and optimize the Python code in /app/workspace/main.py"

# Generate documentation
docker compose run --rm codex codex "Generate comprehensive documentation for the API endpoints"

# Health check and troubleshooting
docker compose exec codex /scripts/health-check.sh

# Container maintenance and updates
docker compose down -v
docker compose pull
docker compose up -d --force-recreate

# Environment configuration validation
docker compose config

# Logs monitoring for debugging
docker compose logs -f codex

# Reset and rebuild for development iterations
docker compose down
docker compose build --no-cache
docker compose up -d

# Generate project structure
docker compose run --rm codex codex "Create a complete project structure for a Python web application"

# Code testing and validation
docker compose run --rm codex bash -c "
  codex 'Generate unit tests for the functions in /app/workspace/utils.py' > /app/workspace/test_utils.py
"

# Multiple code generation tasks
docker compose run --rm codex bash -c "
  echo 'Creating multiple code files...'
  codex 'Generate a database model for user management' > /app/workspace/models.py
  codex 'Create API routes for CRUD operations' > /app/workspace/routes.py
  codex 'Generate configuration management module' > /app/workspace/config.py
"
```
