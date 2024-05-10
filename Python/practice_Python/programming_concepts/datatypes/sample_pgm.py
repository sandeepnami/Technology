# How many ways can 3 fruits be drawn from 100 fruits. 100C3 
import math
n=100
r=3
ways=math.factorial(n)/(math.factorial(r)*math.factorial(n-r))
print("no of ways="+str(ways)) #string concatenation
# another way
from math import factorial 
n=100
r=3
ways=factorial(n)/(factorial(r)*factorial(n-r))
print(f"no of ways={ways}") # using fstring to display results
# yet another way
from math import factorial as fac
n=100
r=3
ways=fac(n)/(fac(r)*fac(n-r))
print(f"no of ways={ways}") # using fstring to display results


# using underscore to fetch prev value or using as a dummy
a=4*3
print(a)
b=5*6
print(b)
#print(f"value of underscore={_}") display of _ underscore only works in REPL >>>_


#Relational Operators
g=20
x=(g==20)
print(x)
x=(g==13)
print(x)
x=(g!=13)
print(x)
x=(g<13)
print(x)
x=(g>13)
print(x)
# identity equality(address) using is operator
a=1234
b=1985
print(f"id of a ={id(a)} ID of b={id(b)}")
b = a           # by this equality function we are passing reference of a to b i.e id() of b now changed to id() of a  
print(f"id of a ={id(a)} ID of b={id(b)}")
bool=(id(a)==id(b))
print(bool)
bool_is= (a is b)
print(f"is comparision {bool_is}") # is operator directly compares id values.
bool_is= (a is None)
print(f"is comparision for NONE NONE--pynull value  {bool_is}")
num=5
print(f"id of num is {id(num)}")
num+=1 # incrementing num with 1
print(f"id of num is {id(num)}")


