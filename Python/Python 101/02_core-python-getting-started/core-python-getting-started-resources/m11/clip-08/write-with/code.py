def write_sequence(filename, num):
    """Write Recaman's sequence to a text file."""
    with open(filename, mode='wt', encoding='utf-8') as f:
        f.writelines(f"{r}\n"
                     for r in islice(sequence(), num + 1))

