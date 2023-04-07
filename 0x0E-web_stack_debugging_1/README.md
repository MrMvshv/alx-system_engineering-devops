#0x0E. Web stack debugging #1
##DevOps
##SysAdmin
##Scripting
##Debugging

###0. Nginx likes port 80

Using your debugging skills, find out what’s keeping your Ubuntu container’s Nginx installation from listening on port 80. Feel free to install whatever tool you need, start and destroy as many containers as you need to debug the issue. Then, write a Bash script with the minimum number of commands to automate your fix.

-> Upon SSHing into the provided ubuntu container, the following took place:

root@dc6172683e33:/#curl localhost
curl: (7) Failed to connect to localhost port 80: Connection refused
root@dc6172683e33:/# service nginx status
 * nginx is not running
root@dc6172683e33:/# service nginx start
root@dc6172683e33:/# curl localhost
curl: (7) Failed to connect to localhost port 80: Connection refused

-> This confirmed that nginx was installed and not running, but after running still didn't serve anything on port 80.

root@dc6172683e33:/# netstat -lpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      26/nginx
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      33/sshd
tcp6       0      0 :::8080                 :::*                    LISTEN      26/nginx

-> netstat showed the listening ports were 8080 and 22

root@dc6172683e33:/# curl localhost:8080
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

-> Awesome, port 8080 works! So nginx is configured to use 8080, let's edit the configuration files for nginx to use port 80 instead of 8080:

root@dc6172683e33:/# sed -i 's/listen 8080 default_server;/listen 80 defa
ult_server;/' /etc/nginx/sites-enabled/default

root@dc6172683e33:/# sed -i 's/listen \[::\]:8080 default_server ipv6only=on;/listen \[::\]:80 default_server ipv6only=on;/g' /etc/nginx/sites-enabled/default

-> Then restart to take effect:

root@dc6172683e33:/# service nginx restart
 * Restarting nginx nginx                                         [ OK ]
root@dc6172683e33:/# curl 0:80
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

-> It works, yay!
-> Alternatively,  /etc/nginx/sites-enabled/default contains the desired configuration, therefore we can use it as shown:

root@b010f8ad84dd:/# sudo rm /etc/nginx/sites-enabled/default
root@b010f8ad84dd:/# sudo ln -s /etc/nginx/sites-available/default /etc/n
ginx/sites-enabled/default
root@b010f8ad84dd:/# sudo service nginx restart
 * Restarting nginx nginx                                         [ OK ]
root@b010f8ad84dd:/# curl localhost
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

-> This works, and seems to be the better fix
