class example42::role::role_mon {
  class { 'apache':
    my_class => 'example42::my_apache',
  }
}
