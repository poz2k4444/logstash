##Install JAVA

Package{
  ensure => present,
}

exec {'add_repo':
  user    => root,
  command => 'add-apt-repository ppa:webupd8team/java && apt-get update'
} ->

package {'oracle-java7-installer':} ->
package {'elasticsearch':}
