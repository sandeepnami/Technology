from babel.numbers import format_number

number = 12345678
print("In the Netherlands we write",
      format_number(number, locale="en_US"),
      "as",
      format_number(number, locale="nl_NL"))
