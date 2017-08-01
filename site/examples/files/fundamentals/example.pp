file { '/etc/motd':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => "Hey, Puppet is fun!\n",
}

package { 'cowsay':
  ensure   => present,
  provider => gem,
}

notify { 'Modify by Enrico': }
