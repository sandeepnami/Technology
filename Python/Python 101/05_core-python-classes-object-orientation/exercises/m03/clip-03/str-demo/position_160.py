class Position:

    def __init__(self, latitude, longitude):
        if not (-90 <= latitude <= +90):
            raise ValueError(f"Latitude {latitude} out of range")

        if not (-180 <= longitude <= +180):
            raise ValueError(f"Longitude {longitude} out of range")

        self._latitude = latitude
        self._longitude = longitude

    @property
    def latitude(self):
        return self._latitude

    @property
    def longitude(self):
        return self._longitude

    @property
    def latitude_hemisphere(self):
        return "N" if self.latitude >= 0 else "S"

    @property
    def longitude_hemisphere(self):
        return "E" if self.longitude >= 0 else "W"

    def __repr__(self):
        return f"{typename(self)}(latitude={self.latitude}, longitude={self.longitude})"

    def __str__(self):
        return f"{self.latitude}° {self.latitude_hemisphere}, {self.longitude}° {self.longitude_hemisphere}"


class EarthPosition(Position):
    pass


class MarsPosition(Position):
    pass


def typename(obj):
    return type(obj).__name__
