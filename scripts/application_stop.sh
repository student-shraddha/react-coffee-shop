#!/bin/bash
# Stop the application
echo "Stopping application..."
pm2 stop  react-coffee-shop || true
