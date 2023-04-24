#!/usr/bin/python3
""" Makes a GET request to a REST API"""
import requests
from sys import argv


if __name__ == '__main__':
    link = 'https://jsonplaceholder.typicode.com/'
    data = requests.get(link + 'users/{}'.format(argv[1])).json()

    u_tasks = requests.get(link + 'todos', params={'userId': argv[1]}).json()

    completed = [t.get('title') for t in u_tasks if t.get('completed') is True]
    print('Employee {} is done with tasks({}/{}):'
          .format(data.get('name'), len(completed), len(u_tasks)))
    [print('\t {}'.format(title)) for title in completed]
