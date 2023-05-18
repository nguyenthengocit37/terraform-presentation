#! /bin/bash
sudo apt install nginx -y
sudo systemctl enable nginx
sudo bash -c 'echo \"Hello, World!\" > /var/www/html/index.html'