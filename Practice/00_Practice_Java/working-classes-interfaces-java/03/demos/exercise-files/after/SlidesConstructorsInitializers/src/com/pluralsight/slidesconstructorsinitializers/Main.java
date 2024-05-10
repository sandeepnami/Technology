package com.pluralsight.slidesconstructorsinitializers;

public class Main {

    public static void main(String[] args) {

        fieldInitializer_CreateEarth();

        constructor_CreatePassengerWithDefaultConstructor();

        constructor_CreatePassengerWithFreeBags();
        constructor_CreatePassengerWithFreeBagsCheckedBags();

        initializerBlock_CreateFlightWithDefaultConstructor();
        initializerBlock_CreateFlightWithFlightNumber();
        initializerBlock_CreateFlightWithFlightClass();
    }

    private static void fieldInitializer_CreateEarth() {
        System.out.println("***************************");
        System.out.println("Field Initializer - Create Earth");
        System.out.println("");

        Earth earth = new Earth();
        System.out.println("Earth circumferenceInMiles = " + earth.getCircumferenceInMiles());
        System.out.println("Earth circumferenceInKms = " + earth.getCircumferenceInKms());

        System.out.println("***************************");
        System.out.println("");
    }

    private static void constructor_CreatePassengerWithDefaultConstructor() {
        System.out.println("***************************");
        System.out.println("Constructor - Create Passenger with Passenger()");
        System.out.println("");

        Passenger bob = new Passenger();
        bob.setCheckedBags(3);

        System.out.println("***************************");
        System.out.println("");
    }

    private static void constructor_CreatePassengerWithFreeBags() {
        System.out.println("***************************");
        System.out.println("Constructor Chaining - Create Passenger with Passenger(int freeBags)");
        System.out.println("");

        Passenger geetha = new Passenger(2);

        System.out.println("***************************");
        System.out.println("");
    }

    private static void constructor_CreatePassengerWithFreeBagsCheckedBags() {
        System.out.println("***************************");
        System.out.println("Constructor Chaining - Create Passenger with Passenger(int freeBags, int checkedBags)");
        System.out.println("");

        Passenger santiago = new Passenger(2, 3);

        System.out.println("***************************");
        System.out.println("");
    }

    private static void initializerBlock_CreateFlightWithDefaultConstructor() {
        System.out.println("***************************");
        System.out.println("Initializer Block - Create Flight with Flight()");
        System.out.println("");

        Flight flight = new Flight();

        System.out.println("***************************");
        System.out.println("");
    }

    private static void initializerBlock_CreateFlightWithFlightNumber() {
        System.out.println("***************************");
        System.out.println("Initializer Block - Create Flight with Flight(int flightNumber)");
        System.out.println("");

        int flightNumber = 100;
        Flight flight = new Flight(flightNumber);

        System.out.println("***************************");
        System.out.println("");

    }

    private static void initializerBlock_CreateFlightWithFlightClass() {
        System.out.println("***************************");
        System.out.println("Initializer Block - Create Flight with Flight(char flightClass)");
        System.out.println("");

        char flightClass = 'A';
        Flight flight = new Flight(flightClass);

        System.out.println("***************************");
        System.out.println("");

    }
}
