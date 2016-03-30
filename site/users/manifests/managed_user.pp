define users::managed_user (
  $shell = '/bin/bash',
  $home = "/home/${title}",
  $ssh_authkey = undef,
  $ssh_authkey_type = 'ssh-rsa',
) {
  $user = $title
  File {
    owner => $user,
  }
  user { $user:
    ensure => present,
    shell => $shell,
  }
  file { $home:
    ensure => directory,
    mode => '0750',
  }
  file { "${home}/.ssh":
    ensure => directory,
    mode => '0700',
  }
  file { "${home}/.vimrc":
    ensure => file,
    replace => false,
    source => 'puppet:///modules/users/vimrc',
  }
  if $ssh_authkey {
    ssh_authorized_key { "${user} default key":
      ensure => present,
      user => $user,
      target => "${home}/.ssh/authorized_keys2",
      type => $ssh_authkey_type,
      key => $ssh_authkey,
    }
  }
}
