#!/usr/bin/python3
"""Queries the Reddit API and prints titles of first 10 hot posts"""

import requests


def count_words(subreddit, word_list, counts=None):
    if counts is None:
        counts = {}

    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=100"
    headers = {"User-Agent": "Mozilla/5.0"}

    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code == 200:
        data = response.json()
        posts = data["data"]["children"]
        if not posts:
            sorted_counts = sorted(counts.items(), key=lambda x: (-x[1], x[0]))
            for word, count in sorted_counts:
                print(f"{word.lower()}: {count}")

        for post in posts:
            title = post["data"]["title"]
            lowercase_title = title.lower()

            for word in word_list:
                if word.lower() in lowercase_title:
                    if word.lower() not in counts:
                        counts[word.lower()] = 1
                    else:
                        counts[word.lower()] += 1

        after = data["data"]["after"]
        if after:
            return count_words(subreddit, word_list, counts=counts)

    return None
