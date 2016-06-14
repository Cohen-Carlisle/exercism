import string

def is_pangram(str):
    lowercase_str = str.lower()
    for char in string.ascii_lowercase:
        if char not in lowercase_str:
            return False
    return True
