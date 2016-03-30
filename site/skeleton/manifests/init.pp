class skeleton {
  file { '/etc/skel' :
    ensure => directory,
  }
  file { skel-bashrc :
    ensure => present,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => "puppet:///modules/skeleton/skel-bashrc",
    path => '/etc/skel/.bash_rc',
  }
}
