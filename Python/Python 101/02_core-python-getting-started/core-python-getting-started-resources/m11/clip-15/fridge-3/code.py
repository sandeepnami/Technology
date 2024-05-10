def raid(food):
    with closing(RefrigeratorRaider()) as r:
        r.open()
        r.take(food)
        # removed explicit call to close()

