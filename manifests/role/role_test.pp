class example42::role::role_test {

  class { 'logstash':
    disable => true,
    install => 'puppi',
  }
  logstash::config { 'local_search':
    template => 'logstash/config/local2elasticsearch.erb',
  }

 # class { 'apache':
 #   disable => true,
 # }

  class { 'mysql':
    absent => true,
  }

  class { 'php':
  }

  class { 'nginx':
    disable => true,
  }

#  class { 'vagrant': }

#  vagrant::environment { 'example42':
#    user => 'example42',
#  }
#  vagrant::vm { 'test_lenny64':
#    environment => 'example42',
#    box         => 'debian_lenny_64',
#    box_url     => 'http://puppetlabs.s3.amazonaws.com/pub/debian_lenny_64.box'
#  }
#  vagrant::vm { "test_lucid64":
#      environment => "example42" ,
#      box => "lucid64" ,
#      box_url => "http://files.vagrantup.com/lucid64.box"
#  }

}
