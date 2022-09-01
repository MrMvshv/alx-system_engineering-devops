#0x01 Shell Permissions

This project contains the shell scripts to do the following:

0. Switch the current user to betty. 
1. Print the effective user name of current user. 
2. Print all groups the current user is part of. 
3. Change the owner of file hello to betty. 
4. Create an empty file called hello.
5. Add execute permission to owner of hello.
6. Add execute permission to the owner and the group owner, and read permission to other users, to the file hello.
7. Adds execution permission to the owner, the group owner and the other users, to the file hello.
8. Set the permission to the file hello as follows:
  Owner: no permission at all
  Group: no permission at all
  Other users: all the permissions
9. Set the mode of the file hello to this:
  -rwxr-x-wx 1 julien julien 23 Sep 20 14:25 hello
10. Set the mode of the file hello the same as olleh’s mode.
11. Add execute permission to all subdirectories of the current directory for the owner, the group owner and all other users. Regular files should not be changed.
12. Create a directory called my_dir with permissions 751 in the working directory.
13. Changes the group owner to school for the file hello
