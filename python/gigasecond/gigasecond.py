from datetime import timedelta

def add_gigasecond(datetime):
    gigasecond = timedelta(seconds = 1000000000)
    return datetime + gigasecond
