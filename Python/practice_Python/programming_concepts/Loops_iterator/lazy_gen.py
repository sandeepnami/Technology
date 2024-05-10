def lucas():
    yield 2
    a=2
    b=1
    while True:
        yield b
        a,b=b,a+b #tuple equality notice reference i.e id of b is moved to id of a and values of a and b are added and assigned to b
count=0        
for luc in lucas():
    count+=1
    print(f"{count} th lucas number  is {luc}") # this is infinite loop so we need to come out by giving CTL+C
    