from fractions import Fraction


class RationalRange:

    def __init__(self, start, stop, num_steps):
        if num_steps != int(num_steps):
            raise ValueError(f"num_steps {num_steps} does not have integral value")
        if num_steps < 1:
            raise ValueError(f"num_steps {num_steps} is not positive")
