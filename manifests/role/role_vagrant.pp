#
#
#
class example42::role::role_vagrant {

  class { 'vagrant': }

  vagrant::environment { 'example42':
    user => 'example42',
  }
  vagrant::vm { 'test_lenny64':
    environment => 'example42',
    box         => 'debian_lenny_64',
    box_url     => 'http://puppetlabs.s3.amazonaws.com/pub/debian_lenny_64.box',
  }
  vagrant::vm { "test_lucid64":
      environment => "example4242" ,
      box => "lucid64" ,
      box_url => "http://files.vagrantup.com/lucid64.box"
  }

}
