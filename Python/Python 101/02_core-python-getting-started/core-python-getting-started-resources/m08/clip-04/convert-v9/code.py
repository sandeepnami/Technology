def convert(s):
    """Convert a string to an integer."""
    try:
        number = ''
        for token in s:
            number += DIGIT_MAP[token]
        return int(number)
    except (KeyError, TypeError):
        return -1
