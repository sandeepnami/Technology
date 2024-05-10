## builtin functions

# Using print function 
#print "Python 2"  # this is acceptable in pthon 2
print("Python 3")  # from python three we need to use print as function only. 
print('Hello, Python') 
message="Hello Python Crash Course world!"
print(message)
message="changed message"
print(message)
print('I told my friend, "Python is my favorite language!"') #using both singla and double quote
print("The language 'Python' is named after Monty Python, not the snake.")  #using both singla and double quote
print("One of Python's strengths is its diverse and supportive community.") #using both singla and double quote
name='Sandeep'
print("Hello " f"{name}" ", would you like to learn some Python today!") #f string usage they are only from python3
first_name='sandeep'
last_name='nami'
full_name=f"{first_name} {last_name}"
print(full_name)
print(f"Hello, {first_name} {last_name}")
print(f"Hello, {full_name.title()}")
#Formatting strings upper case like that
full_name="ritika rukhmini nami"
print(full_name.title())
print(full_name.upper())
print(full_name.lower())
#Trimming spaces
first_name="Sandeep "
last_name=' Nami'
user_name=' test '
print("Right trim="f"{first_name.rstrip()}")
print("Right trim="f"{last_name.lstrip()}")
print("trim="f"{user_name.strip()}")