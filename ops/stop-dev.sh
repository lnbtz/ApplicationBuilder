#!/bin/bash
# stop-dev.sh
# Script to stop development environment and clean up resources

# Change to the script's directory
cd "$(dirname "$0")"

# Check if we should remove volumes
if [[ "$1" == "--clean" ]]; then
  echo "Stopping development environment and removing all volumes..."
  docker compose -f docker-compose.dev.yml --env-file ../.env down -v
else
  echo "Stopping development environment..."
  docker compose -f docker-compose.dev.yml --env-file ../.env down
  echo "To remove volumes and all data, use: ./stop-dev.sh --clean"
fi
