# Puppet script to replace phpp with php

$file_p = '/var/www/html/wp-settings.php'

exec { 'replace':
  command => "sed -i 's/phpp/php/g' ${file_p}",
  path    => ['/bin', '/usr/bin/']
}
