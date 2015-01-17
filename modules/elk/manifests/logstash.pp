class elk::logstash {
  include elk::elasticsearch

  $ls_repo = "deb http://packages.elasticsearch.org/logstash/1.4/debian stable main"
  $ls_tar  = "https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz"

  exec {'download_logstash':
    command => "wget \"$ls_tar\"",
    unless  => 'test -f /home/vagrant/logstash-1.4.2.tar.gz',
    path => ["/bin", "/usr/bin", "/usr/sbin"],
  } ->

  exec {'extract_logstash':
    command => 'tar -zxvf logstash-1.4.2.tar.gz',
    unless  => 'test -d /home/vagrant/logstash-1.4.2/',
    path => ["/bin", "/usr/bin", "/usr/sbin"],
  } ->

  # exec {'add_ls_repository':
  #   user    => root,
  #   command => "echo \"${ls_repo}\" | sudo tee -a /etc/apt/sources.list && sudo apt-get update -y",
  #   path    => ["/bin", "/usr/bin", "/usr/sbin"],
  #   require => Class['elk::elasticsearch'],
  #   unless  => 'grep -c "\logstash/1.4.debian"\  /etc/apt/sources.list',
  # } ->

  # package {'logstash':
  #   ensure => installed,
  # } ->

  exec {'initiate_logstash_tcp':
    user    => 'vagrant',
    #command   => '/opt/logstash/bin/logstash -f /vagrant/logstash_configs/simple_apache_tcp.conf &',
    command   => '/home/vagrant/logstash-1.4.2/bin/logstash -f /vagrant/logstash_configs/simple_apache_tcp.conf &',
    #logoutput => on_failure,
  }
}