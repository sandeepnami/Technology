import functools
import inspect

from auto_repr import auto_repr
from location import Location
from location import hong_kong, stockholm, cape_town, rotterdam, maracaibo


def postcondition(predicate):

    def function_decorator(f):

        @functools.wraps(f)
        def wrapper(self, *args, **kwargs):
            result = f(self, *args, **kwargs)
            if not predicate(self):
                raise RuntimeError(
                    f"Post-condition {predicate.__name__} not "
                    f"maintained for {self!r}"
                )
            return result

        return wrapper

    return function_decorator


def invariant(predicate):
    function_decorator = postcondition(predicate)

    def class_decorator(cls):

        return cls

    return class_decorator


def at_least_two_locations(itinerary):
    return len(itinerary._locations) >= 2


class Itinerary:

    @classmethod
    def from_locations(cls, *locations):
        return cls(locations)

    @postcondition(at_least_two_locations)
    def __init__(self, locations):
        self._locations = list(locations)

    def __str__(self):
        return "\n".join(location.name for location in self._locations)

    @property
    def locations(self):
        return tuple(self._locations)

    @property
    def origin(self):
        return self._locations[0]

    @property
    def destination(self):
        return self._locations[-1]

    @postcondition(at_least_two_locations)
    def add(self, location):
        self._locations.append(location)

    @postcondition(at_least_two_locations)
    def remove(self, name):
        removal_indexes = [
            index for index, location in enumerate(self._locations)
            if location.name == name
        ]
        for index in reversed(removal_indexes):
            del self._locations[index]

    @postcondition(at_least_two_locations)
    def truncate_at(self, name):
        stop = None
        for index, location in enumerate(self._locations):
            if location.name == name:
                stop = index + 1

        self._locations = self._locations[:stop]
