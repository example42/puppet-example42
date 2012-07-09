# = Class: example42::monitor::as
#
# This is a sample monitor class with url checks
# for web applications
#
class example42::monitor::as {

  # Example42 Application checks
  $local_site = $env ? {
    devel => 'latest',
    test  => 'beta',
    prod  => 'www',
  }

  monitor::url { 'Url_Example42_mysql':
    url      => "http://${local_site}.example42.com/checks/mysql",
    port     => '80',
    target   => $::fqdn,
    pattern  => 'OKK',
    enable   => true,
    tool     => $::monitor_tool,
  }

  monitor::url { 'Url_Example42_orient':
    url      => "http://${local_site}.example42.com/checks/orient",
    port     => '80',
    target   => $::fqdn,
    pattern  => 'OKK',
    enable   => true,
    tool     => $::monitor_tool,
  } 

  monitor::url { 'Url_Example42_queue':
    url      => "http://${local_site}.example42.com/checks/queue",
    port     => '80',
    target   => $::fqdn,
    pattern  => 'OKK',
    enable   => false,
    tool     => $::monitor_tool,
  }
}

