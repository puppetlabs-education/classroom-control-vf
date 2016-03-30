class users {
  file { '/home/fundamentals' :
    ensure => directory,
  }
  user { 'fundamentals' :
    ensure => present,
    home => '/home/fundamentals',
  }
}
