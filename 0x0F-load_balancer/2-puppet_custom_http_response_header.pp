# configure nginx with a custom HTTP header response
exec { 'command':
  command  => 'sudo apt-get -y update;
    sudo apt-get -y install nginx;
    sudo ufw allow "Nginx HTTP";
    sudo mkdir -p /var/www/html;
    sudo chmod -R 755 /var/www;
    echo "Hello World!" | sudo tee /var/www/html/index.html;
    echo "Ceci n'est pas une page" | sudo tee /var/www/html/404.html;
    sudo sed -i '/server_name _;/a \        location /redirect_me {\n       return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;\n        }' /etc/nginx/sites-available/default;
    sudo sed -i '/server_name _;/a \        error_page 404 /custom_404.html;\n        location = /custom_404.html {\n                internal;\n        }' /etc/nginx/sites-available/default;
    HOST=$(hostname);
    sudo sed -i "/^http {/a \    add_header X-Served-By $HOST;" /etc/nginx/nginx.conf;
    sudo service nginx restart',
  provider => shell,
}
