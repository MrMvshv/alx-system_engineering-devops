#!/usr/bin/python3
""""Exports to-do list information for a given employee ID to CSV format.""
import requests
from sys import argv


if __name__ == '__main__':
    link = 'https://jsonplaceholder.typicode.com/'
    data = requests.get(link + 'users/{}'.format(argv[1])).json()

    u_tasks = requests.get(link + 'todos', params={'userId': argv[1]}).json()

    with open(f"{argv[1]}.csv", 'w') as csv_file:
        for t in u_tasks:
            u_id = t.get('userId')
            u_nm = data.get('username')
            u_ct = t.get('completed')
            u_tt = t.get('title')

            txt = '"{}","{}","{}","{}"\n'.format(u_id, u_nm, u_ct, u_tt)
            csv_file.write(txt)
