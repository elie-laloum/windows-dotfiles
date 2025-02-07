#!/bin/bash
# bootstrap-wordpress.sh

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <project_name> <theme_path>"
    exit 1
fi

PROJECT_NAME=$1
THEME_PATH=$2
WORDPRESS_DIR="/var/www/html/$PROJECT_NAME"
APACHE_CONF="/etc/apache2/sites-available/$PROJECT_NAME.conf"
DB_NAME="${PROJECT_NAME}_wp"
DB_USER="admin"
DB_PASSWORD="password"
DB_HOST="172.20.0.2"

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

# Create Apache configuration for serving under a subdirectory
sudo tee $APACHE_CONF > /dev/null <<EOL
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    Alias /$PROJECT_NAME "$WORDPRESS_DIR"
    <Directory "$WORDPRESS_DIR">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

# Enable Apache configuration
sudo a2ensite $PROJECT_NAME.conf
sudo a2enmod rewrite
sudo service apache2 reload

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

# Update WordPress site URL and home URL
sudo tee -a $WORDPRESS_DIR/wp-config.php > /dev/null <<EOL
define('WP_HOME', 'http://localhost/$PROJECT_NAME');
define('WP_SITEURL', 'http://localhost/$PROJECT_NAME');
EOL

# Create symlink for theme
sudo ln -s $WORDPRESS_DIR/wp-content/themes/twentytwentyfour $THEME_PATH

echo "WordPress project '$PROJECT_NAME' has been successfully set up!"
echo "You can access it at http://localhost/$PROJECT_NAME"
