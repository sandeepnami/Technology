import string

print("A-Z characterset")
# for i in string.ascii_uppercase:
#     print(i)

print(ord('A'), ord('Z'))
for i in range(ord('A'), ord('Z')+1):
    print(chr(i), end=' ')