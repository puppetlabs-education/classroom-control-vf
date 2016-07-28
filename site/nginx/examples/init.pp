#include nginx

if $::osfamily == 'Windows' {
Package {
provider => chocolatey,
}
}
include nginx
