class MyAlternativeIterable:

    ...

    def __getitem__(self, index):
        if index >= self.number_of_items():
            raise IndexError
        return self.get_element_at(index)
