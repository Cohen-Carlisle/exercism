#
# Skeleton file for the Python "Bob" exercise.
#
import re

def hey(what):
    if silent_treatment(what):
        return 'Fine. Be that way!'
    elif yelled_at(what):
        return 'Whoa, chill out!'
    elif asked_question(what):
        return 'Sure.'
    else:
        return 'Whatever.'

def silent_treatment(what):
    return re.search('\A\s*\Z', what)

def yelled_at(what):
    upper_what = what.upper()
    return re.search('[A-Z]', upper_what) and upper_what == what

def asked_question(what):
    return re.search('\?\Z', what.rstrip())
