class MySequence:

    ...

    def __getitem__(self, index):

        if self.index_out_of_range():
            raise IndexError()
        
        return self.item_at_index(index)


seq = MySequence(...)

item = seq[42]
