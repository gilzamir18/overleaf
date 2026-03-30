#!/usr/bin/env bash

set -euo pipefail

# Script to build and run Overleaf Community Edition locally using Docker Compose.
# Run: ./scripts/start-local.sh

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$ROOT_DIR"

echo "=== Starting local Overleaf environment ==="

command -v docker >/dev/null 2>&1 || { echo "docker not found; install Docker first" >&2; exit 1; }
command -v docker-compose >/dev/null 2>&1 || command -v docker >/dev/null 2>&1 || true
if ! docker compose version >/dev/null 2>&1 && ! docker-compose version >/dev/null 2>&1; then
  echo "docker compose plugin or docker-compose binary is required" >&2
  exit 1
fi

# Optional: build local images from source. If you want to use prebuilt sharelatex/sharelatex
#you may skip this section.
cd server-ce
if command -v make >/dev/null 2>&1; then
  echo "Building server-ce images (base and community)"
  make build-base build-community
else
  echo "Warning: make not found, skipping image build. Ensure shared images are available on Docker Hub."
fi
cd "$ROOT_DIR"

# Ensure persistence directories exist
mkdir -p ~/sharelatex_data ~/mongo_data ~/redis_data

# Start services
if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
  docker compose up -d
else
  docker-compose up -d
fi

cat <<EOF

✅ Overleaf local environment should be running.
Visit http://localhost in your browser.

Useful commands:
  docker compose ps
  docker compose logs -f sharelatex
  ./scripts/stop-local.sh

EOF
