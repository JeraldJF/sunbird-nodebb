#!/bin/sh
set -e

echo "Verifying plugin runtime dependencies..."

if [ -d "node_modules/request-promise" ] || [ -f "node_modules/request-promise/index.js" ]; then
  echo "request-promise: OK"
else
  echo "request-promise: MISSING" >&2
  exit 1
fi

if [ -d "node_modules/connect-multiparty" ] || [ -f "node_modules/connect-multiparty/index.js" ]; then
  echo "connect-multiparty: OK"
else
  echo "connect-multiparty: MISSING" >&2
  exit 1
fi

echo "All plugin runtime dependencies are present."

exit 0
