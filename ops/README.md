# Development Environment

This project uses Docker Compose for local development.

## Setup

1. Copy `.env.example` to `.env` in the root directory and adjust values as needed:
   ```
   cp .env.example .env
   ```

2. Start the development environment:
   ```
   ./ops/start-dev.sh
   ```

3. Access the applications:
   - Frontend: http://localhost:5173
   - Backend API: http://localhost:8080/api/info
   - Database: PostgreSQL on localhost:5432

## Stopping the Environment

To stop the development environment:
```
./ops/stop-dev.sh
```

To stop and remove all volumes (clears the database):
```
./ops/stop-dev.sh --clean
```

## Environment Variables

The `.env` file in the root directory is used for both:
- Docker Compose local development
- Reference for Kubernetes deployment variables

For Kubernetes deployment, environment variables are provided via secrets and ConfigMaps, not directly from the `.env` file.
