# Manifest to fix Nginx open file limit configuration
exec { 'nginx fix open file limit':
  command     => 'sed -i "s/-n 15/-n 4096/" /etc/default/nginx && systemctl restart nginx',
  onlyif      => 'grep -q "-n 15" /etc/default/nginx',  # Check if the old limit exists
  path        => ['/usr/bin', '/bin'],  # Ensure the command can find necessary binaries
  refreshonly => true,  # Execute only when notified
}

# Notify the exec to run if the configuration file is modified
file { '/etc/default/nginx':
  ensure  => file,
  notify  => Exec['nginx fix open file limit'],
}
