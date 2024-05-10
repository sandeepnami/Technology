#Simple generator function
def gen123():
    yield 1
    yield 2
    yield 3

print(f"{gen123()!r}")
g=gen123()
print(f"{next(g)!r}")
print(f"{next(g)!r}")
print(f"{next(g)!r}")
#print(f"{next(g)!r}") # this is end of the yield list
for v in gen123():
    print(v)

h=gen123()
i=gen123()
print(f"{h is i!r}") #check if two assignments of generators are different

def gen246():                                                               
    print("About to yield 2")                                               
    yield 2                                                                 
    print("About to yield 4")                                               
    yield 4                                                                 
    print("About to yield 6")                                               
    yield 6                                                                 
    print("About to return")   
g=gen246()
print(f"{next(g)!r}")  #generator code runs upto first yield i.e 2
print(f"{next(g)!r}")
print(f"{next(g)!r}")
print(f"{next(g)!r}")