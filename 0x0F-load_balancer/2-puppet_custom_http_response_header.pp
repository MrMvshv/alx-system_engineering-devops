# Install and configure Nginx with a custom response header

# add nginx
exec { 'add nginx':
  command => 'sudo add-apt-repository ppa:nginx/stable',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

# update software packages list
exec { 'update packages':
  command => 'apt-get update',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

# install nginx
package { 'nginx':
  ensure  => 'installed',
}

# allow HTTP
exec { 'allow HTTP':
  command => "ufw allow 'Nginx HTTP'",
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  onlyif  => '! dpkg -l nginx | egrep \'îi.*nginx\' > /dev/null 2>&1',
}

# Create the web root directory and set permissions
file { '/var/www/html':
  ensure => directory,
  owner  => 'www-data',
  group  => 'www-data',
  mode   => '0755',
}

# Create "Hello World" page to serve
file { '/var/www/html/index.html':
  content => 'Hello World!\n',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
}

# Create custom 404 page
file { '/var/www/html/404.html':
  content => "Ceci n'est pas une page",
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
}

# Create redirection for website
exec { 'create-nginx-redirection':
  command => 'sed -i "/server_name _;/a \        location /redirect_me {\n       return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;\n        }" /etc/nginx/sites-available/default',
  path    => ['/usr/bin', '/usr/sbin'],
  notify  => Service['nginx'],
  require => Package['nginx'],
}

# Configure Nginx to use the custom 404 page
exec { 'create-nginx-404':
  command => 'sed -i "/server_name _;/a \        error_page 404 /custom_404.html;\n        location = /custom_404.html {\n                internal;\n        }" /etc/nginx/sites-available/default',
  path    => ['/usr/bin', '/usr/sbin'],
  notify  => Service['nginx'],
  require => Package['nginx'],
}

# Add custom header configuration to Nginx
exec { 'add-nginx-custom-header':
  command => "sed -i '/^http {/a \\    add_header X-Served-By $hostname;' /etc/nginx/nginx.conf",
  path    => ['/usr/bin', '/usr/sbin'],
  notify  => Service['nginx'],
  require => Package['nginx'],
}

# Restart Nginx service
service { 'nginx':
  ensure => running,
  enable => true,
  require => [Exec['add nginx'], Exec['update packages'], Package['nginx'],Exec['allow HTTP'], File['/var/www/html'], File['/var/www/html/index.html'], File['/var/www/html/404.html'], Exec['create-nginx-redirection'], Exec['create-nginx-404'], Exec['add-nginx-custom-header']],
}
