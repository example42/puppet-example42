class example42::role::role_munin {
  class { 'apache': 
    my_class => 'example42::my_apache',
  }
}
