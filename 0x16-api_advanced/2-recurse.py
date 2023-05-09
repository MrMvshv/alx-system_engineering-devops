#!/usr/bin/python3
"""Queries the Reddit API and prints titles of hot posts"""

import requests


def recurse(subreddit, hot_list=[], after=None):
    """returns a list containing the titles of all hot articles"""

    url = "https://www.reddit.com/r/{}/hot.json?\
            limit=50&after={}".format(subreddit, after)
    headers = {"User-Agent": "My agent"}

    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code == 200:
        posts = response.json()['data']
        after = posts['after']
        posts = posts['children']

        for post in posts:
            hot_list.append(post['data']['title'])

        if after is not None:
            recurse(subreddit, hot_list, after)
        return hot_list
    else:
        return None
