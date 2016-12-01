class users::admins {
   users::managed_user { 'jose': }
   users::managed_user { ['alice', 'chen']:
      group => 'staff',
   }
   group { 'staff':
      ensure => present,
   }
}
