class MyClass:

    b = "on class"

    def __init__(self):
        self.a = "on instance"
        print(self.a)
        print(MyClass.b)
        print(self.b)
        self.a = "re-bound"
        self.b = "new on instance"
        print(self.b)
        print(MyClass.a)