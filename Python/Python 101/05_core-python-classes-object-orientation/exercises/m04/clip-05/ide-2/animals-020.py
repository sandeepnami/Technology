class Animal:
    @classmethod
    def description(cls):
        return "An animal"


class Bird(Animal):
    @classmethod
    def description(cls):
        return super().description() + " with wings"
