#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

PROJECT_NAME=$1
WORDPRESS_DIR="/var/www/html/$PROJECT_NAME"
APACHE_CONF="/etc/apache2/sites-available/$PROJECT_NAME.conf"
DB_NAME="${PROJECT_NAME}_wp"

# Remove WordPress files
sudo rm -rf $WORDPRESS_DIR

# Remove Apache configuration
sudo rm -f $APACHE_CONF
sudo a2dissite $PROJECT_NAME.conf > /dev/null 2>&1
sudo service apache2 reload 

# Drop database
docker exec -i mariadb mariadb -uadmin -ppassword <<EOF
DROP DATABASE IF EXISTS $DB_NAME;
EOF

echo "WordPress project '$PROJECT_NAME' has been cleaned up!"
