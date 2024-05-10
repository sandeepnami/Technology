def sqrt(x):
    # . . .

def main():
    try:
        print(sqrt(9))
        print(sqrt(2))
        print(sqrt(-1))
        print("This is never printed.")
    except ZeroDivisionError:
        print("Cannot compute square root "
              "of a negative number.")

    print("Program execution continues "
          "normally here.")


if __name__ == '__main__':
    main()
