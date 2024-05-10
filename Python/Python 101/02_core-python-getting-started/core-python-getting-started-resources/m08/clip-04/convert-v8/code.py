def convert(s):
    """Convert a string to an integer."""
    x = -1
    try:
        number = ''
        for token in s:
            number += DIGIT_MAP[token]
        x = int(number)
    except (KeyError, TypeError):
        pass
    return x
