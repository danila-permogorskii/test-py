# FastAPI + PostgreSQL Docker Example

A simple example demonstrating Docker virtual networking with FastAPI and PostgreSQL.

## Quick Start

### 1. Setup Environment Variables

Copy the example file and configure your secrets:

```bash
cp .env.example .env
```

**Important:** The `.env` file contains sensitive information and should NEVER be committed to version control. It's already in `.gitignore`.

### 2. Start the Application

```bash
docker-compose up --build
```

### 3. Test the API

- Health check: http://localhost:8001/health
- Root endpoint: http://localhost:8001
- API docs: http://localhost:8001/docs

### 4. Create a User

```bash
curl -X POST http://localhost:8001/users \
  -H "Content-Type: application/json" \
  -d '{"name": "John Doe", "email": "john@example.com"}'
```

### 5. Get All Users

```bash
curl http://localhost:8001/users
```

## Environment Variables - Best Practices

### Why use `.env` files?

1. **Security**: Keeps secrets out of source code
2. **Flexibility**: Easy to change config without editing code
3. **Separation**: Different values for dev/test/production

### How it works in this project:

```
.env.example  ← Template (committed to git)
       ↓
    .env      ← Your actual secrets (NEVER committed)
       ↓
docker-compose.yml ← Reads variables from .env
```

### Files explained:

- **`.env.example`**: Template showing what variables are needed (safe to commit)
- **`.env`**: Your actual secrets - copy from `.env.example` and fill with real values (git-ignored)
- **`.gitignore`**: Ensures `.env` is never accidentally committed

### For students:

**DO:**
- ✅ Copy `.env.example` to `.env` before running
- ✅ Change default passwords in production
- ✅ Commit `.env.example` as a template
- ✅ Add `.env` to `.gitignore`

**DON'T:**
- ❌ Commit `.env` file to git
- ❌ Share your `.env` file publicly
- ❌ Hardcode passwords in `docker-compose.yml`
- ❌ Use default passwords in production

## Docker Networking

The application demonstrates Docker virtual networking:

- **Service name as hostname**: The FastAPI app connects to PostgreSQL using `db:5432` (not `localhost`)
- **Internal network**: Both containers communicate over `app-network`
- **No external database port**: PostgreSQL is only accessible from inside the Docker network (port 5432 not exposed to host)

## Stop the Application

```bash
# Stop containers
docker-compose down

# Stop and remove database data
docker-compose down -v
```