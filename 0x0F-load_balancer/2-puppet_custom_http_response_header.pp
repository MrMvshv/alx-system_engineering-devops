# Install and configure Nginx with a custom response header

# update software packages list
exec { 'update packages':
  command => 'apt-get update',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

# install nginx
package { 'nginx':
  ensure  => 'installed',
  name    => 'nginx',
  require => Exec['update packages'],
}

# Create the hello world page
file { '/var/www/html/index.html':
  ensure  => present,
  path    => '/var/www/html/index.html',
  content => 'Hello World!\n'
  require => Package['nginx']
}

# Create redirection for website
file_line { 'redirect':
  ensure  => 'present',
  path    => '/etc/nginx/sites-available/default',
  after   => 'listen 80 default_server;',
  line    => 'rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;',
  require => Package['nginx'],
}

# Configure Nginx to use the custom 404 page
file_line { '404_page':
  ensure  => 'present',
  path    => '/etc/nginx/sites-available/default',
  after   => 'server_name _;',
  line    => "error_page 404 /custom_404.html;\n\tlocation = /custom_404.html {\n\tinternal;\n\t}"
  require => Package['nginx'],
}

# Add custom header configuration to Nginx
file_line { 'Header':
  ensure  => 'present',
  path    => '/etc/nginx/sites-available/default',
  after   => 'listen 80 default_server;',
  line    => 'add_header X-Served-By $::hostname;',
  require => Package['nginx'],
}

# Restart Nginx service
service { 'nginx':
  ensure => running,
  require => Package['nginx'],
}
