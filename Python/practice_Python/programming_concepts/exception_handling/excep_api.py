import sys
def sqrt(x):
    """Compute square roots using the method 
    of Heron of Alexandria.

    Args:
        x: The number for which the square root 
            is to be computed.

    Returns:
        The square root of x.
    """
    guess = x
    i = 0
    while guess * guess != x and i < 20:
        guess = (guess + x / guess) / 2.0
        i += 1
    return guess

def sqrt2(x):
    guess = x
    i = 0
    try:
        while guess * guess != x and i < 20:
            guess = (guess + x / guess) / 2.0
            i += 1
    except ZeroDivisionError:
        raise ValueError()
    return guess

def sqrt3(x):
    if x<0 :
            raise ValueError(f"Cannot compute square root--sqrt3 of negative number {x}")
    
    guess = x
    i = 0
    try:
        while guess * guess != x and i < 20:
            guess = (guess + x / guess) / 2.0
            i += 1
    except ZeroDivisionError:
        raise ValueError()
    
    return guess

def main():
    
    try:
        print(sqrt(9))
        print(sqrt(2))
        print(sqrt(-1))
        print("This never will be printed")
    except ZeroDivisionError:
        print("Cannot compute square root of a negative number")        
    print("Program execution continues normally here")
    
    try:
        print(sqrt2(9))
        print(sqrt2(2))
        #print(sqrt2(-1))
        print(sqrt3(9))
        print(sqrt3(2))
        print(sqrt3(-1))
    except ValueError as e:
        print("test")
        print(e,file=sys.stderr) #The error message along with the description passed to exception valueError() will be displayed
    print("Program execution continues normally here")
    

if __name__ == '__main__':
    main()
