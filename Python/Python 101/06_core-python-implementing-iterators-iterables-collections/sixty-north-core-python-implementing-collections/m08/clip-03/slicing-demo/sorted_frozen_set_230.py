class SortedFrozenSet:

    def __init__(self, items=None):
        self._items = sorted(
            set(items) if (items is not None)
            else set()
        )

    def __contains__(self, item):
        return item in self._items

    def __len__(self):
        return len(self._items)

    def __iter__(self):
        return iter(self._items)

    def __getitem__(self, index):
        result = self._items[index]
        return (
            SortedFrozenSet(result)
            if isinstance(index, slice)
            else result
        )
