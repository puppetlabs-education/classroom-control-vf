class skeleton {
  file { '/etc/skel' :
    ensure => directory,
  }
  file { skel-bashrc :
    ensure => present,
    source => "puppet:///modules/skeleton/skel-bashrc",
    path => '/etc/skel/.bash_rc',
  }
}
