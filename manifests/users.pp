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

  # HUMANS
  # UIDs of new users decrease from the "starting" 1999 to avoid
  # conflicts with manually added users
  @user { 'al':
    ensure     => present,
    comment    => 'Al',
    uid        => '1999',
    gid        => '1999',
    password   => '!',
    managehome => true,
    groups     => 'admins',
    shell      => '/bin/bash',
    tag        => 'admins',
    require    => [ Group['admins'] , Group['al'] ],
  }
  @group { 'al':
    ensure     => present,
    gid        => '1999',
    tag        => 'sladmins',
  }

  @user { 'joe':
    ensure     => present,
    comment    => 'Joe',
    uid        => '1998',
    gid        => '1998',
    password   => '!',
    managehome => true,
    groups     => 'developers',
    shell      => '/bin/bash',
    tag        => 'developers',
    require    => [ Group['developers'] , Group['joe'] ],
  }
  @group { 'joe':
    ensure     => present,
    gid        => '1998',
    tag        => 'developers',
  }

  # User Jenkins is used by remote deploys from Jenkins
  # Password: jenkins!
  @user { 'jenkins':
    ensure     => present,
    comment    => 'Jenkins Deployments',
    uid        => '1997',
    gid        => '1997',
    password   => '$6$1p7JJ9.g$iBXOGjIO1EuQVuWI7o/0sh93I0pgml47pmMl6y.EMetovZie50/MjTOmrHbvKjOA6OpuMC8.uFIceUidB2GLe1',
    managehome => true,
    groups     => 'deployers',
    shell      => '/bin/bash',
    tag        => 'deployers',
    require    => [ Group['deployers'] , Group['jenkins'] ],
  }
  @group { 'jenkins':
    ensure     => present,
    gid        => '1997',
    tag        => 'deployers',
  }

}
