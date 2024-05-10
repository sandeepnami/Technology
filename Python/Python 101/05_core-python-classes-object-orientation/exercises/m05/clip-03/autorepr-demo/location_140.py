import inspect

from position import EarthPosition
from utility import typename


def auto_repr(cls):
    print(f"Decorating {cls.__name__} with auto_repr")
    members = vars(cls)
    for name, member in members.items():
        print(name, member)

    if "__repr__" in members:
        raise TypeError(f"{cls.__name__} already defines __repr__")

    if "__init__" not in members:
        raise TypeError(f"{cls.__name__} does not override __init__")

    sig = inspect.signature(cls.__init__)
    parameter_names = list(sig.parameters)[1:]
    print("__init__ parameter names: ", parameter_names)

    return cls


@auto_repr
class Location:

    def __init__(self, name, position):
        self._name = name
        self._position = position

    @property
    def name(self):
        return self._name

    @property
    def position(self):
        return self._position

    def __str__(self):
        return self.name


hong_kong = Location("Hong Kong", EarthPosition(22.29, 114.16))
stockholm = Location("Stockholm", EarthPosition(59.33, 18.06))
cape_town = Location("Cape Town", EarthPosition(-33.93, 18.42))
rotterdam = Location("Rotterdam", EarthPosition(51.96, 4.47))
maracaibo = Location("Maracaibo", EarthPosition(10.65, -71.65))
