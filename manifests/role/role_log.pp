class example42::role::role_log {
  class { 'logstash':
    run_options => "-- web --address 0.0.0.0 --port 9292 --backend elasticsearch://0.0.0.0:9300/",
  }

  logstash::config { 'syslog2elasticsearch':
    template => 'logstash/config/syslog2elasticsearch.erb',
  }
}
