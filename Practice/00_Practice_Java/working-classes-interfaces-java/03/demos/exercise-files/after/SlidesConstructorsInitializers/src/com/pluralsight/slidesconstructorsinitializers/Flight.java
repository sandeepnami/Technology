package com.pluralsight.slidesconstructorsinitializers;

public class Flight {
    private int passengers;
    private int seats = 150;
    private int flightNumber;
    private char flightClass;
    private boolean[] isSeatAvailable = new boolean[seats];

    {
        for(int i = 0; i < seats; i++)
            isSeatAvailable[i] = true;
        System.out.println("executing InitializerBlock");
    }

    public Flight() {
        System.out.println("executing Flight()");
    }

    public Flight(int flightNumber) {
        this.flightNumber = flightNumber;
        System.out.println("executing Flight(int flightNumber)");

    }

    public Flight(char flightClass) {
        this.flightClass = flightClass;
        System.out.println("executing Flight(char flightClass)");
    }

}
