class users::admins {
users::managed_user { 'joe': }
users::managed_user { 'chen': }
users::managed_user { 'alice':
#group => 'staff',
group => 'admin',
#}
#users::managed_user { 'aaron':
#group => 'staff',
}
#group { 'staff':
group { 'admin':
ensure => present,
}
}
