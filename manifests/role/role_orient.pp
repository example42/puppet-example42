# Orient DB Role
class example42::role::role_orient {

  include java

  ## ORIENTDB (Passwords may be set at top scope on a secure datastore
  class { 'orientdb':
    version             => '1.0.1',
    # root_password       => $::orient_root_pw,
    # replicator_password => $::orient_replicator_pw,
  }

  puppi::log { 'orientdb':
    description => "OrientDB logs",
    log         => [ '/opt/orientdb/log/orient-server.log.0' ],
  }
}
