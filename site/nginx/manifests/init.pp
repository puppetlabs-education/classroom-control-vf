class nginx (
    $package = $nginx::params::package,
    $owner = $nginx::params::owner,
    $group = $nginx::params::group,
    $docroot = $nginx::params::docroot,
    $confdir = $nginx::params::confdir,
    $blockdir = $nginx::params::blockdir,
    $logdir = $nginx::params::logdir,
    $service = $nginx::params::service,
    $user = $nginx::params::user,
) inherits nginx::params {
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
  file { $docroot:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    source => 'puppet:///modules/nginx/index.html',
  }
}
