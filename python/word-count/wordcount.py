import re

def word_count(str):
    words = filter(None, re.split("[\W_]+", str.lower()))
    count = {}
    for word in words:
        if word in count:
            count[word] += 1
        else:
            count[word] = 1
    return count
