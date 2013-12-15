# Class example42::minimal
#
# A Class that installs the minimal prerequisites to
# seamless usage of Example42 modules
#
class example42::minimal {

# Basic package management
case $::osfamily {
  redhat: {
    include yum::repo::epel
    include yum::repo::puppetlabs
    package { 'redhat-lsb': ensure => present }
  }
  debian: {
    include apt::repo::puppetlabs
    class { 'apt':
      force_aptget_update => true,
    }
    package { 'lsb-release': ensure => present }
}
  suse: {
    package { 'lsb': ensure => present }
  }
}

}
