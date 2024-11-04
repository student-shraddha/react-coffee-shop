#!/bin/bash

# Navigate to the application directory
cd /home/ec2-user/react-coffee-shop|| exit 1

# Ensure npm is available and install if missing
if ! command -v npm &> /dev/null; then
    echo "npm is not installed. Please install Node.js and npm."
    exit 1
fi

# Ensure PM2 is available and install it if missing
if ! command -v pm2 &> /dev/null; then
    echo "PM2 is not installed. Installing PM2 globally..."
    npm install -g pm2
fi

# Start the application using PM2
pm2 start "npm start" --name "react-coffee"

# Save the PM2 process list and configure it to restart on reboot
pm2 save
pm2 startup -u ec2-user --hp /home/ec2-user
