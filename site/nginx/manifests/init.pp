class nginx (
  $root = undef,
) {
  case $::osfamily {
    'redhat': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
      $logdir = '/var/log/nginx'
      $service = 'nginx'
      $user = 'nginx'
    }
    'debian': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
      $logdir = '/var/log/nginx'
      $service = 'nginx'
      $user = 'www-data'
    }
    'windows': {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx'
      $blockdir = 'C:/ProgramData/nginx/conf.d'
      $logdir = 'C:/ProgramData/nginx/logs'
      $service = 'nginx'
      $user = 'nobody'
    }
    default: { fail("Sorry, your platform '${::osfamily}' is not supported.") }
  }
  $real_docroot = pick($root, $docroot)
  File {
    ensure => file,
    owner => $owner,
    group => $group,
    mode => '0644',
  }
  package { $package:
    ensure => present,
    before => [ File['nginx main config'], File['nginx default block'] ],
  }
  file { 'nginx main config':
    path    => "${confdir}/nginx.conf",
    content => template('nginx/nginx.conf.erb'),
  }
  file { 'nginx default block':
    path    => "${blockdir}/default.conf",
    content => template('nginx/default.conf.erb'),
  }
  service { $service:
    ensure => running,
    enable => true,
    subscribe => [ File['nginx main config'], File['nginx default block'] ],
  }
  file { $real_docroot:
    ensure => directory,
  }
  file { "${real_docroot}/index.html":
    source => 'puppet:///modules/nginx/index.html',
  }
}
