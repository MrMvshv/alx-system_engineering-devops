You have been given 2 additional servers:

gc-[STUDENT_ID]-web-02-XXXXXXXXXX
gc-[STUDENT_ID]-lb-01-XXXXXXXXXX
Let’s improve our web stack so that there is redundancy for our web servers. This will allow us to be able to accept more traffic by doubling the number of web servers, and to make our infrastructure more reliable. If one web server fails, we will still have a second one to handle requests.

0. Double the number of webservers
Requirements:

Configure Nginx so that its HTTP response contains a custom header (on web-01 and web-02)
The name of the custom HTTP header must be X-Served-By
The value of the custom HTTP header must be the hostname of the server Nginx is running on
Write 0-custom_http_response_header so that it configures a brand new Ubuntu machine to the requirements asked in this task
Ignore SC2154 for shellcheck

1. Install your load balancer
mandatory
Install and configure HAproxy on your lb-01 server.

Requirements:

Configure HAproxy so that it send traffic to web-01 and web-02
Distribute requests using a roundrobin algorithm
Make sure that HAproxy can be managed via an init script
Make sure that your servers are configured with the right hostnames: [STUDENT_ID]-web-01 and [STUDENT_ID]-web-02. If not, follow this tutorial.
For your answer file, write a Bash script that configures a new Ubuntu machine to respect above requirements
