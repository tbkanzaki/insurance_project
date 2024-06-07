#!/bin/bash

set -e

echo "Removing PID"
rm -f tmp/pids/server.pid

echo "Running bin/setup"
bin/setup

exec "$@"