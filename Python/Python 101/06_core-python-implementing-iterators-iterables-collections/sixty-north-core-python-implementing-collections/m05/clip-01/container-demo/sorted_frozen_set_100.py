class SortedFrozenSet:

    def __init__(self, items=None):
        self._items = (
            list(items) if (items is not None)
            else list()
        )

    def __contains__(self, item):
        return item in self._items
