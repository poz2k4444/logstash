class elk::elasticsearch {
  include elk::dependencies

  $es_repo = "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main"

  Exec {
    path => ["/bin", "/usr/bin", "/usr/sbin"],
  }

  exec {'get_elasticsearch_gpg_key':
    cwd     => '/home/vagrant/',
    command => 'wget https://packages.elasticsearch.org/GPG-KEY-elasticsearch',
    unless  => 'test -f /home/vagrant/GPG-KEY-elasticsearch',
  } ->

  exec {'add_elasticsearch_key':
    cwd     => '/home/vagrant/',
    user    => root,
    command => 'sudo apt-key add GPG-KEY-elasticsearch',
    unless  => 'sudo apt-key list | grep -c elasticsearch'
  } ->

  exec {'add_es_repository':
    user    => root,
    command => "echo \"${es_repo}\" | sudo tee -a /etc/apt/sources.list && sudo apt-get update -y",
    unless  => 'grep -c "\elasticsearch/1.4.debian"\  /etc/apt/sources.list',
  } ->

  package {'elasticsearch':
    ensure => installed,
  } ->

  service {'elasticsearch':
    ensure => running,
    enable => true,
  }
}
