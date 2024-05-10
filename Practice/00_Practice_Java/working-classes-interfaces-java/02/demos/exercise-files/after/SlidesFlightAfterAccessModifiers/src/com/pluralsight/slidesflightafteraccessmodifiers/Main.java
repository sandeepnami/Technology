package com.pluralsight.slidesflightafteraccessmodifiers;

public class Main {

    public static void main(String[] args) {
	    applyingAccessModifiers1();
        applyingAccessModifiers2();
        specialReferences();
        accessorsAndMutators();
    }

    private static void applyingAccessModifiers1() {
        System.out.println("***************************");
        System.out.println("Applying Access Modifiers 1");
        System.out.println("");

        Flight flight1 = new Flight();
        // System.out.println(flight1.passengers);//ERROR!!
        flight1.add1Passenger();

        System.out.println("Ran successfully");
        System.out.println("***************************");
        System.out.println("");
    }

    private static void applyingAccessModifiers2() {
        System.out.println("***************************");
        System.out.println("Applying Access Modifiers 2");
        System.out.println("");

        Flight flight2 = new Flight();
        //flight2.handleTooMany();//ERROR!!
        flight2.add1Passenger();

        System.out.println("Ran successfully");
        System.out.println("***************************");
        System.out.println("");
    }

    private static void specialReferences() {
        System.out.println("***************************");
        System.out.println("Special References");
        System.out.println("");

        Flight lax1 = new Flight();
        Flight lax2 = new Flight();

        // add passengers to both flights
        populateFlights(lax1, lax2);

        Flight lax3 = null;
        if(lax1.hasRoom(lax2))
            lax3 = lax1.createNewWithBoth(lax2);

        if(lax3 != null)
            System.out.println("Flights combined");

        System.out.println("Ran successfully");
        System.out.println("***************************");
        System.out.println("");
    }

    private static void populateFlights(Flight lax1, Flight lax2) {
        int passengersPerFlight = (int)(lax1.getSeats() / 2.0d);
        lax1.setPassengers(passengersPerFlight);
        lax2.setPassengers(passengersPerFlight);
    }

    private static void accessorsAndMutators() {
        System.out.println("***************************");
        System.out.println("Accessors and Mutators");
        System.out.println("");

        Flight slcToNyc = new Flight();
        slcToNyc.setSeats(200);
        System.out.println(slcToNyc.getSeats());

        System.out.println("***************************");
        System.out.println("");
    }

}
