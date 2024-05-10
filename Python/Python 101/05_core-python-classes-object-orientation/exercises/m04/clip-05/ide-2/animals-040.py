class Animal:
    @classmethod
    def description(cls):
        return "An animal"


class Bird(Animal):
    @classmethod
    def description(cls):
        s = super()
        print(s)
        return s.description() + " with wings"


class Flamingo(Bird):
    @classmethod
    def description(cls):
        return super().description() + " and fabulous pink feathers"
