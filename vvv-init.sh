# Init script for Waitlist Testing

echo "Commencing Waitlist Testing"

# Make a database, if we don't already have one
echo "Creating database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS wcwl_test"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON wcwl_test.* TO wp@localhost IDENTIFIED BY 'wp';"

# Download WordPress
if [ ! -d htdocs ]
then
	echo "Installing WordPress using WP CLI"
	mkdir htdocs
	cd htdocs
	wp core download --allow-root
	wp core config --allow-root --quiet --dbname="wcwl_test" --dbuser=wp --dbpass=wp --dbhost="localhost" <<PHP
define( 'WP_DEBUG', true );
PHP
	wp core install --allow-root --quiet --url=wcwl_test.dev --title="Waitlist Testing" --admin_user="admin" --admin_password="password" --admin_email="admin@local.dev"

	# Delete unneeded default themes and plugins
	wp plugin delete --allow-root --quiet hello
	wp plugin delete --allow-root --quiet akismet
	wp theme delete --allow-root --quiet twentyfifteen
	wp theme delete --allow-root --quiet twentyfourteen

	# Get any plugins that are needed for development
	wp plugin install --allow-root --quiet query-monitor
	wp plugin install --allow-root --quiet debug-bar
	wp plugin install --allow-root --quiet user-switching
	wp plugin install --allow-root --quiet easy-wp-smtp

	# Update options
	wp option update --allow-root --quiet blogdescription ''
	wp option update --allow-root --quiet start_of_week 1
	wp option update --allow-root --quiet timezone_string 'Europe/London'
	wp option update --allow-root --quiet permalink_structure '/%postname%/'
	wp option update --allow-root wp_smtp_options < ../smtp.config

	# Grab WooCommerce and Waitlist
	cd wp-content/plugins
	#git clone git@github.com:woothemes/woocommerce.git
	#git clone git@github.com:woothemes/woocommerce-waitlist.git
	wp plugin activate --allow-root --all
	cd ../../..
fi

# Update everything
cd htdocs
wp core update --allow-root
wp plugin update --allow-root --all
wp theme update --allow-root --all

cd ..

# The Vagrant site setup script will restart Nginx for us
echo "Waitlist Testing site now installed";
