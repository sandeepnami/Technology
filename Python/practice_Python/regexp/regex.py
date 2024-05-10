def solve_for_exp(a, b):
    count = 1
    result = a
    while result < b:
        result *= a
        count += 1
    return count

print(solve_for_exp(4,1024))