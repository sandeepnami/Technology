import unittest

from sorted_frozen_set import SortedFrozenSet


class TestConstruction(unittest.TestCase):

    def test_construct_empty(self):
        s = SortedFrozenSet([])

    def test_construct_from_non_empty_list(self):
        s = SortedFrozenSet([7, 8, 3, 1])

    def test_construct_from_an_iterator(self):
        items = [7, 8, 3, 1]
        iterator = iter(items)
        s = SortedFrozenSet(iterator)

    def test_construct_no_args(self):
        s = SortedFrozenSet()


class TestContainerProtocol(unittest.TestCase):

    def setUp(self):
        self.s = SortedFrozenSet([6, 7, 3, 9])

    def test_positive_contained(self):
        self.assertTrue(6 in self.s)

    def test_negative_contained(self):
        self.assertFalse(2 in self.s)

    def test_positive_not_contained(self):
        self.assertTrue(5 not in self.s)

    def test_negative_not_contained(self):
        self.assertFalse(9 not in self.s)


class TestSizedProtocol(unittest.TestCase):

    def test_empty_with_default(self):
        s = SortedFrozenSet()
        self.assertEqual(len(s), 0)

    def test_empty(self):
        s = SortedFrozenSet([])
        self.assertEqual(len(s), 0)

    def test_one(self):
        s = SortedFrozenSet([42])
        self.assertEqual(len(s), 1)

    def test_ten(self):
        s = SortedFrozenSet(range(10))
        self.assertEqual(len(s), 10)

    def test_with_duplicates(self):
        s = SortedFrozenSet([5, 5, 5])
        self.assertEqual(len(s), 1)


class TestIterableProtocol(unittest.TestCase):

    def setUp(self):
        self.s = SortedFrozenSet([7, 2, 1, 1, 9])

    def test_iter(self):
        iterator = iter(self.s)
        self.assertEqual(next(iterator), 1)
        self.assertEqual(next(iterator), 2)
        self.assertEqual(next(iterator), 7)
        self.assertEqual(next(iterator), 9)
        self.assertRaises(
            StopIteration,
            lambda: next(iterator)
        )

    def test_for_loop(self):
        expected = [1, 2, 7, 9]
        index = 0
        for item in self.s:
            self.assertEqual(item, expected[index])
            index += 1


class TestSequenceProtocol(unittest.TestCase):

    def setUp(self):
        self.s = SortedFrozenSet([1, 4, 9, 13, 15])

    def test_index_zero(self):
        self.assertEqual(self.s[0], 1)

    def test_index_four(self):
        self.assertEqual(self.s[4], 15)

    def test_index_one_beyond_the_end(self):
        with self.assertRaises(IndexError):
            self.s[5]

    def test_index_minus_one(self):
        self.assertEqual(self.s[-1], 15)

    def test_index_minus_five(self):
        self.assertEqual(self.s[-5], 1)

    def test_index_one_before_the_beginning(self):
        with self.assertRaises(IndexError):
            self.s[-6]

    def test_slice_from_start(self):
        self.assertEqual(self.s[:3], SortedFrozenSet([1, 4, 9]))

    def test_slice_to_end(self):
        self.assertEqual(self.s[3:], SortedFrozenSet([13, 15]))

    def test_slice_empty(self):
        self.assertEqual(self.s[10:], SortedFrozenSet())

    def test_slice_arbitrary(self):
        self.assertEqual(self.s[2:4], SortedFrozenSet([9, 13]))

    def test_slice_step(self):
        self.assertEqual(self.s[0:5:2], SortedFrozenSet([1, 9, 15]))

    def test_slice_full(self):
        self.assertEqual(self.s[:], self.s)


class TestReprProtocol(unittest.TestCase):

    def test_repr_empty(self):
        s = SortedFrozenSet()
        self.assertEqual(repr(s), "SortedFrozenSet()")


if __name__ == "__main__":
    unittest.main()
