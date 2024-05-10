class SortedFrozenSet:

    def __init__(self, items=None):
        self._items = (
            set(items) if (items is not None)
            else set()
        )

    def __contains__(self, item):
        return item in self._items

    def __len__(self):
        return len(self._items)
