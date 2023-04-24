#!/usr/bin/python3
"""Accessing a REST API for todo lists of employees"""
import requests
import json
from sys import argv


if __name__ == '__main__':
    link = 'https://jsonplaceholder.typicode.com/'
    data = requests.get(link + 'users/{}'.format(argv[1])).json()

    u_tasks = requests.get(link + 'todos', params={'userId': argv[1]}).json()

    with open(f"{argv[1]}.json", 'w') as json_file:
        json.dump({argv[1]: [{
            "task": t.get('title'),
            "completed": t.get('completed'),
            "username": data.get('username')
        } for t in u_tasks]}, json_file)