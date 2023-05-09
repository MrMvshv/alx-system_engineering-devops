#!/usr/bin/python3

"""retrieve top ten hot topics per subreddit"""
import requests


def top_ten(subreddit):
    """get top ten hot topics"""

    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"
    headers = {"User-Agent": "My agent"}
    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code == 200:
        data = response.json()
        posts = data["data"]["children"]

        for post in posts:
            title = post["data"]["title"]
            print(title)
    else:
        print(None)
