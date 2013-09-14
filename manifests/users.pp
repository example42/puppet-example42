# Class: example::users
# 
# Here are defined some sample users and groups and a simple
# approach to users management
# Note: Place encrypted passwords in among single quotes '
# to avoid interpolation of $ sign.
# The UID is decremental to avoid conflicts with users eventually added
# manually (they get by default the first UID after the higher)
#
class example42::users {

  # GROUPS
  @group { 'admins':
    ensure => present,
    gid    => '999',
    tag    => 'admins',
  }

  @group { 'developers':
    ensure => present,
    gid    => '998',
    tag    => 'developers',
  }

  @group { 'deployers':
    ensure => present,
    gid    => '997',
    tag    => 'deployers',
  }

  # ROOT (Password: example42)
  @user { 'root':
    ensure     => present,
    password   => '$6$vBEPA3af$RFqXswJnXqzAoLQ6eLNnRWKJNGq6Ic1yulsRUt2l199V8aMbEvgeUwgrwqD59tbs4UpoaY1C.fWt.3zVzVs570',
  }

  # USERS
  # UIDs of new users decrease from the "starting" 1999 to avoid
  # conflicts with manually added users

  @user::managed { 'example42':
    ensure             => present,
    name_comment       => 'Example42 Sample User',
    uid                => '1998',
    # password           => $secret::user_password_example42,
    # password_crypted   => true,
    managehome         => true,
    groups             => 'developers',
    tag                => 'developers',
    # sshkey_source      => "example42/user/pubkeys/example42",
    # bashprofile_source => "example42/user/bashprofile",
    manage_group       => true,
  }

  # User Jenkins is used by remote deploys from Jenkins
  # Password: jenkins!
  @user::managed { 'jenkins':
    ensure             => present,
    name_comment       => 'Jenkins Deployments',
    uid                => '1997',
    password           => '$6$1p7JJ9.g$iBXOGjIO1EuQVuWI7o/0sh93I0pgml47pmMl6y.EMetovZie50/MjTOmrHbvKjOA6OpuMC8.uFIceUidB2GLe1',
    managehome         => true,
    groups             => 'deployers',
    tag                => 'deployers',
    password_crypted   => true,
    manage_group       => true,
  }

}
