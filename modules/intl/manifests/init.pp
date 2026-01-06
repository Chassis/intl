# A Chassis extensions to add Php internationalisation to your Chassis server
#
# @param config Configuration hash for the extension
# @param path Path to the extension directory
class intl (
  Hash $config,
  String $path = '/vagrant/extensions/intl'
) {
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
    require => Package["${$php_package}-fpm"],
    notify  => Service["${$php_package}-fpm"],
  }
}
