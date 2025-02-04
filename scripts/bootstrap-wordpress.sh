#!/bin/bash
# bootstrap-wordpress.sh

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <project_name> <theme_path>"
    exit 1
fi

PROJECT_NAME=$1
THEME_PATH=$2
WORDPRESS_DIR="/var/www/html/$PROJECT_NAME"
NGINX_CONF="/etc/nginx/sites-available/$PROJECT_NAME"
NGINX_CONF_ENABLED="/etc/nginx/sites-enabled/$PROJECT_NAME"
DB_NAME="${PROJECT_NAME}_wp"
DB_USER="admin"
DB_PASSWORD="password"
DB_HOST="mariadb"

# Create WordPress directory with sudo
sudo mkdir -p $WORDPRESS_DIR

# Download and extract WordPress
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
sudo cp -r /tmp/wordpress/* $WORDPRESS_DIR/
rm -rf /tmp/wordpress /tmp/latest.tar.gz

# Create themes directory first
sudo mkdir -p $WORDPRESS_DIR/wp-content/themes

# Download and extract default theme
wget https://downloads.wordpress.org/theme/twentytwentyfour.zip
unzip twentytwentyfour.zip
sudo rm -rf $WORDPRESS_DIR/wp-content/themes/twentytwentyfour
sudo mv twentytwentyfour $WORDPRESS_DIR/wp-content/themes/
rm twentytwentyfour.zip

# Set permissions
sudo chown -R www-data:www-data $WORDPRESS_DIR
sudo chmod -R 755 $WORDPRESS_DIR

# Create Nginx configuration
sudo tee $NGINX_CONF > /dev/null <<EOL
server {
    listen 80;
    server_name localhost;

    root /var/www/html/$PROJECT_NAME;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOL

# Enable Nginx configuration
sudo ln -s $NGINX_CONF $NGINX_CONF_ENABLED
sudo nginx -t && sudo systemctl reload nginx

# Create MySQL database using docker exec with root
docker exec -i mariadb mariadb -uroot -ppassword <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'admin'@'%';
FLUSH PRIVILEGES;
EOF

# Create wp-config.php with sudo
sudo cp $WORDPRESS_DIR/wp-config-sample.php $WORDPRESS_DIR/wp-config.php
sudo sed -i "s/database_name_here/$DB_NAME/g" $WORDPRESS_DIR/wp-config.php
sudo sed -i "s/username_here/$DB_USER/g" $WORDPRESS_DIR/wp-config.php
sudo sed -i "s/password_here/$DB_PASSWORD/g" $WORDPRESS_DIR/wp-config.php
sudo sed -i "s/localhost/$DB_HOST/g" $WORDPRESS_DIR/wp-config.php

# Create symlink for theme
sudo ln -s $WORDPRESS_DIR/wp-content/themes/twentytwentyfour $THEME_PATH

echo "WordPress project '$PROJECT_NAME' has been successfully set up!"
echo "You can access it at http://localhost/$PROJECT_NAME"