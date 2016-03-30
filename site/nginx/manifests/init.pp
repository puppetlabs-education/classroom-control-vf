class nginx {
  package { 'nginx' :
    ensure => present,
  }
  
  file { '/var/www' :
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755',
  }
  
  file { '/var/www/index.html' :
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/nginx/conf.d' :
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755',
  }
  
  file { '/var/nginx/conf.d/default.conf' :
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/nginx/index.html',
    require => Package[ 'nginx' ],
    notify => Service[ 'nginx' ],
  }
  
  service { 'nginx' :
    ensure => running,
    enable => true,
    subscribe => File[ '/var/nginx/conf.d/default.conf' ],
  }
}
