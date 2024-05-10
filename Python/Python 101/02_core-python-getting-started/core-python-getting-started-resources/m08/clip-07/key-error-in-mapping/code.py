def lookup(key):
    if not find_key(key):
        raise KeyError()
    return value(key)
