class nginx {

  File {
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0664',
  }

  package { 'nginx' :
    ensure => present,
    before => [ File[ '/etc/nginx/nginx.conf' ], File[ '/etc/nginx/conf.d/default.conf' ],
  }
  
  file { '/var/www' :
    ensure => directory,
  }
  
  file { '/var/www/index.html' :
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/etc/nginx/conf.d' :
    ensure => directory,
  }
  
  file { '/etc/nginx/nginx.conf' :
    source => 'puppet:///modules/nginx/nginx.conf',
    notify => Service[ 'nginx' ],
  }

  file { '/etc/nginx/conf.d/default.conf' :
    source => 'puppet:///modules/nginx/default.conf',
    notify => Service[ 'nginx' ],
  }
  
  service { 'nginx' :
    ensure => running,
    enable => true,
  }
}
