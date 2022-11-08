#!/usr/bin/env bash
# Write a Bash script that sets up your web servers for the deployment of web_static
apt-get -y update
apt-get -y install nginx
mkdir -p /data/
mkdir -p /data/web_static/
mkdir -p /data/web_static/releases/
mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/releases/test/

# Create a fake HTML file
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" >> /data/web_static/releases/test/index.html

#Create a symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# ownership of the /data/ folder to the ubuntu user AND group
sudo chown -hR ubuntu:ubuntu /data/

#Update the Nginx configuration to serve the content 
sudo sed -i '41i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current;\n\t}\n' /etc/nginx/sites-available/default
sudo ln -sf '/etc/nginx/sites-available/default' '/etc/nginx/sites-enabled/default'
#restart serveur
sudo service nginx restart
