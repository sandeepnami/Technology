# list comprehension
words="Why sometimes i have believed as many as six impossible things before breakfast".split()                                                           
print(f"{words!r}")                                                                  
print(f"{[len(word) for word in words]!r}")    #[expr(item) for item in iterable]

from math import factorial
f=[len(str(factorial(x))) for x in range(20)]
print(f)                                    
f=[factorial(x) for x in range(20)]
print(f)                                    

#set comprehensions
from math import factorial
s={len(str(factorial(x))) for x in range(20)} #sets are un-ordered containers and also eliminate the duplicates. 
print(s)     

#dict comprehensions
"""{
    key_expr(item): value_expr(item)
    for item in iterable
}
"""
country_to_capital={
    'United Kingdom':'London',
    'Brazil': 'Brasília',
    'Morocco': 'Rabat',                                  
    'Sweden': 'Stockholm' 
    }
#dict.items() returns tuples of key value pairs  
capital_to_country = {capital: country for country, capital in country_to_capital.items()}     #inverting key-value pairs of a dictionary.                                                           
from pprint import pprint as pp                                             
pp(capital_to_country)                                                      

words = ["hi", "hello", "foxtrot", "hotel"]                                 
{ x[0]: x for x in words }                                                  
{'h': 'hotel', 'f': 'foxtrot'}  

#complex comprehension
import os
import glob
file_sizes={os.path.realpath(p):os.stat(p).st_size for p in glob.glob('*.py')}
pp(file_sizes)

# Filter Comprehensions
from math import sqrt                                                       
def is_prime(x):                                                            
    if x < 2:                                                               
        return False                                                        
    for i in range(2, int(sqrt(x)) + 1):                                    
        if x % i == 0:                                                      
            return False                                                    
    return True                                                             
prime_nos=[x  for x in range(1,100) if is_prime(x)]
print(prime_nos)
#square of prime numbers and divisors
prime_square_divisors = {x*x: (1, x, x*x) for x in range(20) if is_prime(x)}
pp(prime_square_divisors)  