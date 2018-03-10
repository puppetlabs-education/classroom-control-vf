# Windows requires a plain text password, but Linux requires a hash.
# Both password values are the same.
$password = $osfamily ? {
  'RedHat'  => '$1$HdDw//gC$2VBiQ1x5blLPwNS.G.Iw21',
  'windows' => 'Puppet8Labs!',
}

skeleton::managed_user { ['aaron', 'kaitlin', 'alison']:
  password => $password,
}
