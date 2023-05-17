# Puppet script to fix nginx to sustain heavy load


$file_p = '/etc/default/nginx'

exec { 'replace':
  command => "sed -i 's/^ULIMIT.*/ULIMIT=\"-n 4096\"/' ${file_p}",
  path    => ['/bin', '/usr/bin/'],
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure    => 'running',
  enable    => true,
  subscribe => Exec['replace'],
}
