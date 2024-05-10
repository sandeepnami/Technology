def convert(s):
    """Convert a string to an integer."""
    x = -1
    try:
        number = ''
        for token in s:
            number += DIGIT_MAP[token]
        x = int(number)
        print(f"Conversion succeeded! x = {x}")
    except (KeyError, TypeError):
        print("Conversion failed!")
    return x
