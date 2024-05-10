class SortedList(SimpleList):
    def add(self, item):
        super().add(item)
        self.sort()
