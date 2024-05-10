def display_nth_root(radicand, n):
  root = nth_root(radicand, n)
  message = "The " + ordinal(n) + " root of " + str(radicand) + " is " + str(root)
  print(message)