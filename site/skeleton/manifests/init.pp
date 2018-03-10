class skeleton {
  file { '/etc/skel':
#    ensure => ???,   # what value should go here?
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  
  # add a resource to manage /etc/skel/.bashrc


}
