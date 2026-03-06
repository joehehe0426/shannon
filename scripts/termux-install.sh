#!/usr/bin/env bash

set -euo pipefail

if [[ ! -f "package.json" ]]; then
  echo "ERROR: Run this script from the Shannon repository root."
  exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
  echo "ERROR: npm is not installed."
  echo "Install Node.js in Termux first, for example:"
  echo "  pkg update && pkg install nodejs-lts git"
  exit 1
fi

echo "Installing root dependencies..."
npm install

echo "Installing mcp-server dependencies..."
npm --prefix mcp-server install

echo "Building mcp-server..."
npm --prefix mcp-server run build

echo "Building Shannon..."
npm run build

cat <<'EOF'

Termux install completed.

Shannon runtime requires Docker/Podman compose services.
Termux users typically connect to a remote engine:
  export DOCKER_HOST=tcp://<docker-host>:2375

Then run:
  ./shannon help
  ./shannon start URL=<url> REPO=<repo-name>

EOF
