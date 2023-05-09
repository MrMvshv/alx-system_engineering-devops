#!/usr/bin/python3
"""Queries the Reddit API and prints titles of hot posts"""

import requests


def recurse(subreddit, hot_list=[]):
    """returns a list containing the titles of all hot articles"""

    url = "https://www.reddit.com/r/{}/hot.json?limit=100".format(subreddit)
    headers = {"User-Agent": "My agent"}

    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code == 200:
        data = response.json()
        posts = data["data"]["children"]

        if not posts:
            return hot_list

        for post in posts:
            title = post["data"]["title"]
            hot_list.append(title)

        after = data["data"]["after"]
        if after:
            return recurse(subreddit, hot_list=hot_list)
        else:
            return hot_list

    return None
