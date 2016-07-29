class nginx (
$root = undef,
) {
case $::osfamily {
'redhat','debian' : {
$package = 'nginx'
$owner = 'root'
$group = 'root'
# $docroot = '/var/www'
$confdir = '/etc/nginx'
$logdir = '/var/log/nginx'
# this will be used if we don't pass in a value
$default_docroot = '/var/www'
}
'windows' : {
$package = 'nginx-service'
$owner = 'Administrator'
$group = 'Administrators'
# $docroot = 'C:/ProgramData/nginx/html'
$confdir = 'C:/ProgramData/nginx'
$logdir = 'C:/ProgramData/nginx/logs'
# this will be used if we don't pass in a value
$default_docroot = 'C:/ProgramData/nginx/html'
}
default : {
fail("Module ${module_name} is not supported on ${::osfamily}")
}
}
# user the service will run as. Used in the nginx.conf.erb template
$user = $::osfamily ? {
'redhat' => 'nginx',
'debian' => 'www-data',
'windows' => 'nobody',
}
# if $root isn't set, then fall back to the platform default
$docroot = $root ? {
undef => $default_docroot,
default => $root,
}
File {
owner => $owner,
group => $group,
mode => '0664',
}
package { $package:
ensure => present,
}
file { [ $docroot, "${confdir}/conf.d" ]:
ensure => directory,
}
file { "${docroot}/index.html":
ensure => file,
source => 'puppet:///modules/nginx/index.html',
}
file { "${confdir}/nginx.conf":
ensure => file,
content => template('nginx/nginx.conf.erb'),
notify => Service['nginx'],
}
file { "${confdir}/conf.d/default.conf":
ensure => file,
content => template('nginx/default.conf.erb'),
notify => Service['nginx'],
}
service { 'nginx':
ensure => running,
enable => true,
}
}
