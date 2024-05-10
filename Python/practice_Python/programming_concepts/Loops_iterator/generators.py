def take(count, iterable):
    counter = 0
    for item in iterable:
        if counter == count:
            return
        counter += 1
        yield item


def distinct(iterable):
    seen = set()
    for item in iterable:
        if item in seen:
            continue
        yield item
        seen.add(item)


items = [3, 6, 6, 2, 1, 1]
# Here notice that the arguments for take 3,distint(items) will be passed directly to generator
for item in take(3, distinct(items)):     
    print(item)

# Here notice that here arguments for take 3,distint(items) since list is included first distinct gen will execute 
# for all items and then list of the yields of the disntict gen is passed as second argument to take gen  
for item in take(3, list(distinct(items))):     
    print(item)
