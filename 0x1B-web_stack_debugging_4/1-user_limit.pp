# Puppet manifest to increase file limits of user

exec { 'backup limits.conf':
  command => "cp /etc/security/limits.conf /etc/security/limits.conf.bak",
  path    => '/bin',
  onlyif  => 'test -e /etc/security/limits.conf', # Run only if the file exists
}

exec { 'file limit config':
  command => "sed -i 's/nofile [0-9]\+/nofile 100/g' /etc/security/limits.conf",
  path    => '/bin',
  onlyif  => 'grep -q "nofile" /etc/security/limits.conf', # Run only if "nofile" is found
}
