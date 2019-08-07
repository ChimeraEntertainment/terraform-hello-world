#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
sudo service nginx start
sudo sed -i 's/Welcome to nginx!/Chimera, welcome to nginx!/' /var/www/html/index.nginx-debian.html