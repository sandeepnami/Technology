class AbstractClass:

    def template_method(self):
        self._part1()  # No implementation
        self._part2()  # Abstract implementation
        self._part3()  # Default implementation

    def _part2(self):
        raise NotImplementedError("Override this method")

    def _part3(self):
        print("Done!") # Optionally override


class ConcreteClass(AbstractClass):

    def _part1(self):
        print("About to perform action")

    def _part2(self):
        perform_action()

    def _part3(self):
        print("Action performed!")
