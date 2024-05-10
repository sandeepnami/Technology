## Python provides some built-in iteration tools like enumerate() and sum()
## itertools module provides more tools like islice(),count()
from cgi import print_environ
from itertools import count,islice
from Comprehensions import is_prime
thousand_primes=islice((x for x in count() if is_prime(x)),1000)
print(f"thousand_primes={thousand_primes!r}") #this is just like lazy generator no calculation is made
print(f"running the generator and fetch last 10 primes from first 1000 {list(thousand_primes)[-10:]}")
sum_primes=sum(islice((x for x in count() if is_prime(x)),1000)) 
print(f"sum of first 1000 primes={sum_primes}")


## any determines if any element in series is true. note that we need to pass only one argument as array/list.
bool_any=any([False,False,True])
print(f"bool_any={bool_any}")
## all determines if all elements in series is true.note that we need to pass only one argument as array/list.
bool_all=all([False,False,True])
print(f"bool_all={bool_all}")

#To find if there are any prime numbers in the range of 1328 to 1360 inclusive
any_prime=any(is_prime(x) for x in range(1328,1361))
print(f"any_prime={any_prime}")
cities=['London', 'Paris', 'Tokyo', 'New York', 'Sydney', 'Kuala Lumpur']
all_first_caps=all(city==city.title() for city in cities)  # check if first letter of the cities is capital
print(f"all_first_caps={all_first_caps}")

#using zip() function
sunday = [12, 14, 15, 15, 17, 21, 22, 22, 23, 22, 20, 18]
monday = [13, 14, 14, 14, 16, 20, 21, 22, 22, 21, 19, 17]
for item in zip(sunday, monday):                                            
    print(item)    #zip yields tuples when iterated
for sun,mon in zip(sunday,monday):
    print("average=",(sun+mon)/2) # using print in simple format.
tuesday = [2, 2, 3, 7, 9, 10, 11, 12, 10, 9, 8, 8]
from pprint import pp
pp(zip(sunday, monday,tuesday))
for temperatures in zip(sunday,monday,tuesday):
    print(f"min = {min(temperatures):4.1f}, max={max(temperatures):4.1f}, average={sum(temperatures) / len(temperatures):4.1f}") 

#lazy concatenation of iterables
from itertools import chain
temperatures_chain=chain(sunday,monday,tuesday)
check=all(t>0 for t in temperatures_chain)
print("check if all the temperatures are above freezing point",check)

# using infinite loop lucas function in lazy generation
from lazy_gen import lucas
for luc_prime in (p for p in lucas() if is_prime(p)):
    print("lucas numbers that are primes=",luc_prime) 