#!/usr/bin/env bash
set -e

nohup /app/hashengine/target/release/hash-server &
HASH_SERVER_PID=$!

nohup npm start &
WEB_UI_PID=$!

# On SIGTERM/SIGINT, kill both
cleanup() {
    echo "Stopping..."
    kill "$HASH_SERVER_PID" "$WEB_UI_PID" 2>/dev/null || true
}

# Trap signals
trap cleanup INT TERM

# Wait for processes to exit
wait

exit 0
