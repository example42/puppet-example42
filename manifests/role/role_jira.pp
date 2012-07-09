class example42::role::role_jira {

  class { 'mysql':
    root_password => 'auto',
  }

}
