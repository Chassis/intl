# A Chassis extensions to add Php internationalisation to your Chassis server
class intl (
	$config,
	$path = '/vagrant/extensions/intl'
) {

	apt::ppa { 'universe': }

	if ( ! empty( $::config[disabled_extensions] ) and 'chassis/intl' in $config[disabled_extensions] ) {
		$package = absent
	} else {
		$package = latest
	}

	$php = $config[php]

	if versioncmp( $php, '5.4') <= 0 {
		$php_package = 'php5'
	}
	else {
		$php_package = "php${$php}"
	}

	package { "${$php_package}-intl":
		ensure  => $package,
		require => [ Package["${$php_package}-fpm"], Apt::Ppa['universe'] ],
		notify  => Service["${$php_package}-fpm"]
	}
}
