#!/bin/bash

echo "=== Docker and Python Test Script ==="
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Current workspace: $WORKSPACE"
echo ""

echo "=== Checking Docker ==="
docker --version || echo "Docker not available"
docker images | grep python || echo "No Python Docker images found"
echo ""

echo "=== Checking Python ==="
which python3 || echo "python3 not found"
which python || echo "python not found"
python3 --version || echo "python3 version check failed"
echo ""

echo "=== Checking PATH ==="
echo "PATH: $PATH"
echo ""

echo "=== Checking if we're in Docker container ==="
if [ -f /.dockerenv ]; then
    echo "Running inside Docker container"
else
    echo "NOT running inside Docker container"
fi
echo ""

echo "=== Available commands ==="
ls -la /usr/bin/python* 2>/dev/null || echo "No Python in /usr/bin"
ls -la /usr/local/bin/python* 2>/dev/null || echo "No Python in /usr/local/bin"
echo ""

echo "=== Test complete ===" 