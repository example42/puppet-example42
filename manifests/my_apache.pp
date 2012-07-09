# = Class: example42::my_apache
#
# This is a sample apache custom class
# It adds a general, or per role, htpasswd
# and a index.html blank page, if not present
#
class example42::my_apache {

  require apache

  # General htpasswd file
  file { 'example42_htpasswd':
    ensure  => present ,
    path    => "${apache::config_dir}/example42.htpasswd",
    mode    => '0750',
    owner   => $apache::process_user,
    group   => $apache::process_user,
    source  => [ "puppet:///modules/example42/apache/example42.htpasswd-${role}" ,
                 'puppet:///modules/example42/apache/example42.htpasswd' ],
  }

  case $::role {
    'puppet': { include example42::my_apache_ssl }
    default: {}
  }

  file { 'index_html':
    ensure  => present ,
    path    => "${apache::data_dir}/index.html",
    replace => false,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }
 
}
