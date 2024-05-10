package com.pluralsight.slidesstaticimport;

public class Flight {
    private int passengers, seats = 150;
    private static int allPassengers;

    public static int getAllPassengers() {
        return allPassengers;
    }

    public static void resetAllPassengers() {
        allPassengers = 0;
    }

    public void add1Passenger() {
        if(passengers < seats) {
            passengers += 1;
            allPassengers += 1;
        }
    }

    public int getSeats() {
        return seats;
    }

    public void setSeats(int seats) {
        this.seats = seats;
    }

    public int getPassengers() {
        return passengers;
    }

}
