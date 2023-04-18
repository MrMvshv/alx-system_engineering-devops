0x14. MySQL

0. Install MySQL
mandatory
First things first, let’s get MySQL installed on both your web-01 and web-02 servers.

MySQL distribution must be 5.7.x
Make sure that task #3 of your SSH project is completed for web-01 and web-02. The checker will connect to your servers to check MySQL status
Please make sure you have your README.md pushed to GitHub.

1. Let us in!
mandatory
In order for us to verify that your servers are properly configured, we need you to create a user and password for both MySQL databases which will allow the checker access to them.

Create a MySQL user named holberton_user on both web-01 and web-02 with the host name set to localhost and the password projectcorrection280hbtn. This will allow us to access the replication status on both servers.
Make sure that holberton_user has permission to check the primary/replica status of your databases.
In addition to that, make sure that task #3 of your SSH project is completed for web-01 and web-02. You will likely need to add the public key to web-02 as you only added it to web-01 for this project. The checker will connect to your servers to check MySQL status

2. If only you could see what I've seen with your eyes
mandatory
In order for you to set up replication, you’ll need to have a database with at least one table and one row in your primary MySQL server (web-01) to replicate from.

Create a database named tyrell_corp.
Within the tyrell_corp database create a table named nexus6 and add at least one entry to it.
ake sure that holberton_user has SELECT permissions on your table so that we can check that the table exists and is not empty.
