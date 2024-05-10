package com.pluralsight.slidesstaticmembers;

public class Flight {
    private int passengers, seats = 150;
    private static int allPassengers;
    private static int maxPassengersPerFlight;

    static {
        AdminService admin = new AdminService();
        admin.connect();

        maxPassengersPerFlight = admin.isRestricted() ?
                admin.getMaxFlightPassengers() : Integer.MAX_VALUE;

        admin.close();
        System.out.println("executing static initialization block");
    }

    public static int getAllPassengers() {
        return allPassengers;
    }

    public static void resetAllPassengers() {
        allPassengers = 0;
    }

    public void add1Passenger() {
        if(passengers < seats && passengers < maxPassengersPerFlight) {
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
