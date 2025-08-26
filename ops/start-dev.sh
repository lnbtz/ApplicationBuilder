#!/bin/bash
# start-dev.sh
# Script to start development environment with Docker Compose
# Uses the .env file from the root directory

# Change to the script's directory
cd "$(dirname "$0")"

# Check if .env file exists in the root directory
if [ ! -f "../.env" ]; then
  echo "Error: .env file not found in the root directory."
  echo "Please create it based on .env.example."
  exit 1
fi

# Start Docker Compose with the root .env file
docker compose -f docker-compose.dev.yml --env-file ../.env up -d "$@"

echo "Development environment started!"
echo "- Frontend: http://localhost:5173"
echo "- Backend API: http://localhost:8080/api/info"
