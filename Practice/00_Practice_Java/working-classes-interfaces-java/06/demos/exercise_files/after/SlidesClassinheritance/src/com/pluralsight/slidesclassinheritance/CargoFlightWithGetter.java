package com.pluralsight.slidesclassinheritance;

public class CargoFlightWithGetter extends FlightWithGetter{
    float maxCargoSpace = 1000.0f;
    float usedCargoSpace;
    int getSeats() {
        return 12;
    }

    public void add1Package(float h, float w, float d) {
        float size = h * w * d;
        if (hasCargoSpace(size))
            usedCargoSpace += size;
        else
            handleNoSpace();
    }

    private boolean hasCargoSpace(float size) {
        return usedCargoSpace + size <= maxCargoSpace;
    }

    private void handleNoSpace() {
        System.out.println("Not enough space");
    }
}
