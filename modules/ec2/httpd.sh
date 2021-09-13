#!/bin/bash
sudo bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl status httpd
sudo systemctl start httpd
sudo systemctl status httpd
sudo rm -rf /var/www/html/index.html
sudo touch /var/www/html/index.html
sudo cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<body>
<h1>This is opstrain</h1>
</body>
</html>
EOF
sudo mkdir -p /var/www/html/opstrain
sudo chown -R $USER:$USER /var/www/html/opstrain
sudo chmod -R 755 /var/www/html/opstrain
sudo cp /var/www/html/index.html /var/www/html/opstrain/
sudo mkdir /var/www/html/opstrain/log/
sudo touch /var/www/html/opstrain/log/error.log
sudo touch /var/www/html/opstrain/log/requests.log
sudo mkdir -p /var/www/html/opstrain1
sudo chown -R $USER:$USER /var/www/html/opstrain1
sudo chmod -R 755 /var/www/html/opstrain1
sudo cp /var/www/html/index.html /var/www/html/opstrain1/
sudo mkdir /var/www/html/opstrain1/log/
sudo touch /var/www/html/opstrain1/log/error.log
sudo touch /var/www/html/opstrain1/log/requests.log
sudo mkdir /etc/httpd/sites-available/ /etc/httpd/sites-enabled/
sudo touch /etc/httpd/sites-available/opstrain.conf
sudo cat << EOF > /etc/httpd/sites-available/opstrain.conf
<VirtualHost *:80>
    ServerName opstrain.com
    ServerAlias opstrain.com
    DocumentRoot /var/www/opstrain/html
    ErrorLog /var/www/opstrain/log/error.log
    CustomLog /var/www/opstrain/log/requests.log combined
</VirtualHost>
<VirtualHost *:90>
    ServerName opstrain.com
    ServerAlias opstrain.com
    DocumentRoot /var/www/opstrain1/html
    ErrorLog /var/www/opstrain1/log/error.log
    CustomLog /var/www/opstrain1/log/requests.log combined
</VirtualHost>
EOF
sudo ln -s /etc/httpd/sites-available/opstrain.conf /etc/httpd/sites-enabled/
sudo mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.backup
sudo cp /var/www/html/index.html /etc/httpd/conf.d/
sudo systemctl reload httpd

sudo systemctl status httpd