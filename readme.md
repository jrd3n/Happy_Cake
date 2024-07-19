# Happy cake factory

A basic web app with https.

# Install

Put a fresh ubuntu image on a RPI. ssh in and run the following script.

```bash

# Update and upgrade the system
sudo apt update -y && sudo apt upgrade -y

# Install system dependencies
sudo apt install -y python3-pip nginx openssl unzip

# Setup directory for the project
mkdir -p ~/happy_cake_factory
cd ~/happy_cake_factory

# Download the application code and Nginx config from GitHub
wget https://github.com/jrd3n/Happy_Cake/archive/refs/heads/main.zip

# Unzip the application code
unzip main.zip
cd Happy_Cake-main  # Adjust this if the directory structure is different

# Install Python dependencies
sudo python3 -m pip install -r requirements.txt --break-system-packages

# Setup SSL certificates
sudo mkdir -p /etc/ssl/nginx

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/nginx/nginx-selfsigned.key \
    -out /etc/ssl/nginx/nginx-selfsigned.crt \
    -subj "/C=UK/ST=Hemel/L=Hemel/O=Happy Cake Factory/OU=IT Department/CN=happycakefactory.bsi/emailAddress=admin@happycakefactory.bsi"

# Configure Nginx
sudo cp nginx.conf /etc/nginx/sites-available/happy_cake.conf
sudo ln -s /etc/nginx/sites-available/happy_cake.conf /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default

# Restart Nginx to apply the changes
sudo systemctl restart nginx

# Clean up APT
sudo rm -rf /var/lib/apt/lists/*

# Note: Adjust the CMD equivalent command based on your specific start.sh script or application start command.
# For example, if `start.sh` is supposed to start your application, make sure it is executable:
chmod +x start.sh

# Add your script to the crontab to run at reboot
(crontab -l 2>/dev/null; echo "@reboot sleep 60 && python3 ~/happy_cake_factory/Happy_Cake-main/app.py >> ~/log") | crontab -

# End of script
sudo reboot -n

``` 