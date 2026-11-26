#!/bin/bash
# Opens Overlay Studio in your browser from this folder, using macOS's built-in Python
# as a small web server on this Mac only (nothing is reachable from other computers).
cd "$(dirname "$0")" || exit 1
PORT=8417
if ! curl -s -o /dev/null "http://127.0.0.1:$PORT/index.html"; then
  nohup python3 -m http.server "$PORT" --bind 127.0.0.1 >/dev/null 2>&1 &
  disown
  for _ in 1 2 3 4 5 6 7 8 9 10; do
    curl -s -o /dev/null "http://127.0.0.1:$PORT/index.html" && break
    sleep 0.3
  done
fi
open "http://localhost:$PORT/"
