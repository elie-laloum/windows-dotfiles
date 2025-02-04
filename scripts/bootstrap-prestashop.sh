#!/bin/bash
# bootstrap-prestashop.sh

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <project_name> <theme_path>"
    exit 1
fi

PROJECT_NAME=$1
THEME_PATH=$2
PRESTASHOP_DIR="/var/www/html/$PROJECT_NAME"
APACHE_CONF="/etc/apache2/sites-available/$PROJECT_NAME.conf"
DB_NAME="${PROJECT_NAME}_ps"
DB_USER="admin"
DB_PASSWORD="password"
DB_HOST="mariadb"

# Create PrestaShop directory with sudo
sudo mkdir -p $PRESTASHOP_DIR

# Download and extract PrestaShop
cd /tmp
wget https://github.com/PrestaShop/PrestaShop/releases/download/8.2.0/prestashop_8.2.0.zip
unzip prestashop_8.2.0.zip
sudo unzip prestashop.zip -d $PRESTASHOP_DIR
rm -rf prestashop_8.2.0.zip prestashop.zip Install_PrestaShop.html index.php

# Set permissions
sudo chown -R www-data:www-data $PRESTASHOP_DIR
sudo chmod -R 755 $PRESTASHOP_DIR

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

    Alias /$PROJECT_NAME "$PRESTASHOP_DIR"
    <Directory "$PRESTASHOP_DIR">
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
sudo systemctl reload apache2

# Create MySQL database using docker exec with root
docker exec -i mariadb mariadb -uroot -ppassword <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'admin'@'%';
FLUSH PRIVILEGES;
EOF

# Run PrestaShop installation wizard
echo "Please complete the PrestaShop installation wizard at http://localhost/$PROJECT_NAME"
echo "Database details:"
echo "Database server: $DB_HOST"
echo "Database name: $DB_NAME"
echo "Database user: $DB_USER"
echo "Database password: $DB_PASSWORD"

# Create symlink for theme (after installation)
echo "After installation, create a symlink for the theme:"
echo "sudo ln -s $PRESTASHOP_DIR/themes/classic $THEME_PATH"

echo "PrestaShop project '$PROJECT_NAME' has been successfully set up!"
echo "You can access it at http://localhost/$PROJECT_NAME"
