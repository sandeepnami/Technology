"""Demonstrate raiding a refrigerator."""

class RefrigeratorRaider:
    """Raid a refrigerator"""

    def open(self):
        print("Open fridge door.")

    def take(self, food):
        print(f"Finding {food}...")
        if food == 'deep fried pizza':
            raise RuntimeError("Health warning!")
        print(f"Taking {food}")

    def close(self):
        print("Close fridge door.")

def raid(food):
    r = RefrigeratorRaider()
    r.open()
    r.take(food)
    r.close()

