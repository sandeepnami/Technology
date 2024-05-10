package com.pluralsight.slidesmoreinheritance;

public class FullLicensePilot extends Pilot {
    @Override
    public boolean canAccept(Flight f) {
        return true;
    }
}
