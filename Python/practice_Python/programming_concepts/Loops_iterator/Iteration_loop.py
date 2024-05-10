# Looping through Lists or Arrays
iterable=["Spring","Summer","Autumn","Winter",]
for x in iterable:
      print(x)
      
iterable=["Spring","Summer","Autumn","Winter",]
iterator = iter(iterable)                                                   
print(f"{next(iterator)!r}")                                                              
print(f"{next(iterator)!r}")                                                
print(f"{next(iterator)!r}")                                                
print(f"{next(iterator)!r}")                                                
#print(f"{next(iterator)!r}")     # StopIteration exception when the list reaches end                                           

def first(iterable):
    iterator=iter(iterable)
    try:
        return next(iterator)
    except StopIteration:
        raise ValueError("Iterable is empty")

print(f"{first(['1st', '2nd', '3rd'])!r}") 
print(f"{first({'1st', '2nd', '3rd'})!r}")  
print(f"{first(set())!r}")  #handled exception StopIteration and raised as value error with description