def convert(s):
    try:
        number = ''
        for token in s:
            number += DIGIT_MAP[token]
        x = int(number)
        print(f"Conversion succeeded! x = {x}")
    except KeyError:
        print("Conversion failed!")
        x = -1
    return x
