# generator expressions
# syn (expr(item) for in item in iterable) notice that comprehensions have same syntax but square braces are used
million_squares=(x*x for x in range(1,1000001)) # at this point no squares are calculated 

# at this point ony last 10 squares will be calculated and returned. 
# also note we need to pass the gen expr to convert to list tehn from list fetch -10 values
print(list(million_squares)[-10:])
print(list(million_squares)[0:10]) # fetch first 10 squares but since yield is completed we dont get starting yield

# generators saving significant memory
sum1=sum(x*x for x in range(1,10000001)) # if we generate list first we will be consuming 400mb of mem
print(sum1)

# importing functions in project folder #modules using path
from Comprehensions import is_prime 
sum_primes=sum(x for x in range(1,1001) if is_prime(x))
print(f"sum of primes upto 1000 = {sum_primes}")