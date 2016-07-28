define users::managed_user (
$group = $title,
) {
user { $title:
ensure => present,
}
file { "/home/${title}":
ensure => directory,
owner => $title,
group => $group,
}
}
