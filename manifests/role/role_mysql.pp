# Mysql Role
class example42::role::role_mysql {

  class { 'mysql':
    root_password => 'auto',
  }

}
