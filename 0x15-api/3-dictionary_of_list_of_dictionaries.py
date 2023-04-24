#!/usr/bin/python3
"""Makes a GET request to a REST API.
exports data in JSON format.
"""
import requests
import json


if __name__ == '__main__':
    link = 'https://jsonplaceholder.typicode.com/'
    data = requests.get(link + 'users').json()

    with open('todo_all_employees.json', 'w') as f:
        json.dump({
            u.get('id'): [{
                "task": t.get('title'),
                "completed": t.get('completed'),
                "username": u.get('username')
            } for t in requests.get(link + 'todos',
                                    params={"userId": u.get('id')}).json()]
            for u in data}, f)
