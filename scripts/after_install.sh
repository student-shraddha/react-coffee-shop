#!/bin/bash

# Navigate to the application directory
cd /home/ec2-user/react-coffee-shop || exit 1

# Install npm if it's not already installed
if ! command -v npm &> /dev/null; then
    echo "npm is not installed. Installing npm and Node.js..."
    curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
    sudo yum install -y nodejs
fi

# Install project dependencies
echo "Installing project dependencies..."
npm install

# Build the Next.js application for production
echo "Building the application..."
npm run build

# Install PM2 globally if it's not already installed
if ! command -v pm2 &> /dev/null; then
    echo "PM2 is not installed. Installing PM2 globally..."
    npm install -g pm2
fi

# Stop any previous instance of the application running on PM2
echo "Stopping any existing PM2 instances..."
pm2 stop react-coffee-shop || true

# Start the application with PM2
echo "Starting the application with PM2..."
pm2 start npm --name "coffee-shop" -- start

# Save the PM2 process list and configure it to restart on system reboot
echo "Saving PM2 process list and setting up startup script..."
pm2 save
pm2 startup -u ec2-user --hp /home/ec2-user

echo "after_install.sh script completed."
