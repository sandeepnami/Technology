class LevelOrderIterator:

    def __init__(self, sequence):
        self._sequence = sequence
        self._index = 0

    def __next__(self):
        if self._index >= len(self._sequence):
            raise StopIteration
        result = self._sequence[self._index]
        self._index += 1
        return result

    def __iter__(self):
        return self
