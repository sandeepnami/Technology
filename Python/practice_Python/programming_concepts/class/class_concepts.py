# # types and classes
# print("type of integer",type(5))
# print("type of string",type("Python"))
# print("type of lists",type([1,2,3]))
# print("type of generator returns",(x*x for x in [1,2,3]))

# # Declaring Classes
# class MyClassName:
#     #     ⬆
#     # By convention, class
#     # names use CamelCase
#     # . . .
#     pass

# """Model for aircraft flights."""
# class Flight:
#     pass
# print("Type of the flight class object ",Flight) 
# f=Flight()  # Here Flight() is constructor function/method
# print("Type of the flight class object ",f) 

# class Flight1:
#     def number(self):
#         return "SN060"
# print("Type of the flight class object ",Flight) 
# f=Flight1()  
# print("return of the instance method ",f.number()) # using instance methods
# print("return of the instance method ",Flight1.number()) # another way of invoking instance methods with class name

class Flight2:
    def __init__(self,number):
        # here number variable doesnt exist but by assigning we will create this number var instance
        self._number=number   # this _number is also called as class invariants
    def number(self):
        return self._number
f=Flight2("SN060") # passing flight number at the time creation of flight object  
print("return of the instance method ",f.number()) # using instance methods
# we can directly access implementation attributes details aswell but it is suggested not to. may be used in debugging though
print("return of the instance method ",f._number) 

# Valid Flight number 
class Flight3:
    def __init__(self,number):
        if not number[:2].isalpha():
            raise ValueError(f"invalid airline code in {number}")
        if not number[:2].isupper():
            raise ValueError(f"airline code must be uppercase {number}")
        if not(number[2:].isdigit() and int(number[2:]) <=9999):
            raise ValueError(f"invalid route number {number}")
        self._number=number   # this _number is also called as class invariants

    def number(self):
        return self._number

f=Flight3("SN060")  
print("return of the instance method ",f.number()) 
#f1=Flight3("060")  #enter inalid flight number
# f2=Flight3("sn060")  #enter inalid flight number
f3=Flight3("SN12345")  #enter inalid flight number