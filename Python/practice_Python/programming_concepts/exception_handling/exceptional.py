import sys
from math import log
DIGIT_MAP = {
    'zero':  '0',
    'one':   '1',
    'two':   '2',
    'three': '3',
    'four':  '4',
    'five':  '5',
    'six':   '6',
    'seven': '7',
    'eight': '8',
    'nine':  '9',
}

def convert(s):
    try:
        number = ''
        for token in s:
            number += DIGIT_MAP[token]
        x = int(number)
        print(f"Conversion succeeded! for x = {x}")
    except KeyError:
        print(f"conversion failed!! for s = {s} for key token={token}")
        x=-1
    except TypeError:
        print(f"conversion failed!!! for s = {s}")
        x=-1
    return x

def convert2(s):
    try:
        number = ''
        for token in s:
            number += DIGIT_MAP[token]
        x = int(number)
        print(f"Conversion succeeded! for x = {x}")
    except (KeyError,TypeError) as e:
        print(f"conversion error is: {e!r}",file=sys.stderr)
        x=-1
    return x

def convert3(s):
    try:
        number = ''
        for token in s:
            number += DIGIT_MAP[token]
        x = int(number)
        print(f"Conversion succeeded! for x = {x}")
        return x
    except (KeyError,TypeError) as e:
        print(f"conversion error is: {e!r}",file=sys.stderr)
        raise
    

def string_log(s):
    v=convert3(s)
    return log(v)
