# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A FastAPI application demonstrating Docker networking with PostgreSQL database integration. The project showcases microservices communication through Docker Compose virtual networks.

## Architecture

- **FastAPI Application** (`test.py`): Main web service exposing REST API endpoints
- **PostgreSQL Database**: Persistent data storage running in a separate container
- **Docker Virtual Network**: Enables container-to-container communication using service names as hostnames

The application connects to PostgreSQL using the service name defined in `docker-compose.yml`, demonstrating Docker's internal DNS resolution within the virtual network.

## Development Commands

### Setup (First Time)

```bash
# Create .env file from template
cp .env.example .env

# Edit .env with your values (already has defaults for local dev)
```

### Running the Application

```bash
# Start all services (FastAPI + PostgreSQL) with Docker Compose
docker-compose up --build

# Start in detached mode
docker-compose up -d --build

# Stop all services
docker-compose down

# Stop and remove volumes (clears database)
docker-compose down -v
```

### Local Development

```bash
# Install dependencies
pip install -r requirements.txt

# Run FastAPI locally (requires PostgreSQL connection)
uvicorn test:app --host 0.0.0.0 --port 8001 --reload
```

### Database Operations

```bash
# Access PostgreSQL container
docker-compose exec db psql -U postgres -d testdb

# View database logs
docker-compose logs db

# View application logs
docker-compose logs web
```

## Environment Configuration

### Best Practices for Secrets Management

This project follows the `.env` pattern for managing secrets:

1. **`.env.example`**: Template file (committed to git) showing required variables
2. **`.env`**: Actual secrets file (git-ignored, created by copying `.env.example`)
3. **`.gitignore`**: Ensures `.env` never gets committed
4. **`docker-compose.yml`**: References variables using `${VARIABLE_NAME}` syntax

### Environment Variables

- `DATABASE_URL`: PostgreSQL connection string using service name `db` as hostname
- `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`: Database credentials
- `APP_PORT`: Port where FastAPI runs (default: 8001)

All sensitive data is kept in `.env` and never hardcoded in source files.

## API Endpoints

- `GET /`: Health check endpoint
- `GET /users`: Fetch all users from database
- `POST /users`: Create new user (expects JSON body with user data)
- Additional database-related endpoints demonstrate CRUD operations

## Docker Network Details

The `docker-compose.yml` defines a custom bridge network (`app-network`) that allows the FastAPI container to communicate with the PostgreSQL container using the service name `db` as the hostname. This eliminates the need for localhost or external IP addresses.