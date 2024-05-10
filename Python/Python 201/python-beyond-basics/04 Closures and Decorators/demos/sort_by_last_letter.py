store = []


def sort_by_last_letter(strings):
    def last_letter(s):
        return s[-1]
    store.append(last_letter)
    print(last_letter)
    return sorted(strings, key=last_letter)

sorted_new = sort_by_last_letter(['Hello','Nalini','Ritika','Pradyumna'])
print(sorted_new)

def sort_by_last_letter1(strings):
    last_letter1 = lambda s: s[-1]
    return sorted(strings, key=last_letter1)

sorted_new = sort_by_last_letter(['Hello','Nalini','Ritika','Pradyumna'])
print(sorted_new)