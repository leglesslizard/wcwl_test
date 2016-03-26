# VVV Site Bootstrap

Bootstrap a new site in [VVV](https://github.com/Varying-Vagrant-Vagrants/VVV) using [WP-CLI](http://wp-cli.org), PHP and MySQL.

To get started:

1. Clone this repo or download into the `www` directory of VVV as `www/wcwl_test`
2. Do a find/replace for `wcwl_test` and replace with the site slug text
3. Do a find/replace for `Waitlist Testing` and replace with the full name of the site
4. Configure any site-specific options with `wp-cli` commands in  `vvv-init.sh`
5. If your Vagrant box is running, from the Vagrant directory run `vagrant halt`
6. Run `vagrant up --provision`

Visit http://wcwl_test.dev (replace wcwl_test with your site slug)

Note: This repo is setup with my personal username and email of choice. Make sure to change them before using for your own development.
