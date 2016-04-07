class users::managed_users {
  users::managed_user { 'dbrandwein':
    ssh_authkey => 'whatwouldyoudoooforaklondikebar',
  }
  
  users::managed_user { 'tomcat7':
    home => '/opt/tomcat7',
    shell => '/sbin/nologin',
  }
  
  users::managed_user { ['jose', 'alice', 'chen']: }
}
