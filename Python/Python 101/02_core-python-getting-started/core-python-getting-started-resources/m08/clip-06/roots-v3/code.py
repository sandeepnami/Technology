def sqrt(x):
    # . . .

def main():
    print(sqrt(9))
    print(sqrt(2))
    try:
        print(sqrt(-1))
    except ZeroDivisionError:
        print("Cannot compute square root "
              "of a negative number.")

    print("Program execution continues "
          "normally here.")


if __name__ == '__main__':
    main()
