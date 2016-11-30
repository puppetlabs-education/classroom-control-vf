class memcached {
 package { 'memcached':
  ensure => present,
 }
 
 file { 'memcached':
  ensure  => file,
  path    => '/etc/sysconfig/memcached',
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => 'puppet:///modules/memcached/memcached',
  require => Package['memcached'],
 }
 
 service {'memcached':
  ensure    => running,
  enable    => true,
  subscribe => File['memcached'],
 }
}
