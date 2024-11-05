#!/bin/bash

# Navigate to the application directory
cd /home/ec2-user/react-coffee-shop || exit 1

# Ensure npm is available and installed if missing
if ! command -v npm &> /dev/null; then
    echo "npm is not installed. Please install Node.js and npm."
    exit 1
fi

# Ensure PM2 is available and install it if missing
if ! command -v pm2 &> /dev/null; then
    echo "PM2 is not installed. Installing PM2 globally..."
    npm install -g pm2
fi

# Stop any existing PM2 instance of the application to avoid duplicates
echo "Stopping any existing PM2 instances of 'react-coffee'..."
pm2 stop react-coffee || true
pm2 delete react-coffee || true

# Start the application using PM2
echo "Starting the application with PM2..."
pm2 start "npm start" --name "react-coffee"

# Save the PM2 process list and configure it to restart on reboot
echo "Saving PM2 process list and setting up startup script..."
pm2 save
pm2 startup systemd -u ec2-user --hp /home/ec2-user | sudo tee /etc/systemd/system/pm2-ec2-user.service > /dev/null

echo "Deployment script completed successfully."
