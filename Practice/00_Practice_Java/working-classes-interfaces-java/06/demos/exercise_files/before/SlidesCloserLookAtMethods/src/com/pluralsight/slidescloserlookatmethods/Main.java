package com.pluralsight.slidescloserlookatmethods;

public class Main {

    public static void main(String[] args) {
	    passByReference_ModifyReferences();
	    passByReference_ModifyObjects();
	    overloading();
	    variableLengthParameterList();
    }

    private static void passByReference_ModifyReferences() {
        System.out.println("***************************");
        System.out.println("Pass by Reference - Modify References");
        System.out.println("");

        Flight val1 = new Flight(10);
        Flight val2 = new Flight(20);

        System.out.println("Flight numbers before swapFlight - val1:" +
                val1.getFlightNumber() + " val2:" + val2.getFlightNumber());

        swapFlight(val1, val2);

        System.out.println("Flight numbers after swapFlight - val1:" +
                val1.getFlightNumber() + " val2:" + val2.getFlightNumber());

        System.out.println("***************************");
        System.out.println("");

    }

    private static void passByReference_ModifyObjects() {
        System.out.println("***************************");
        System.out.println("Pass by Reference - Modify Objects");
        System.out.println("");

        Flight val1 = new Flight(10);
        Flight val2 = new Flight(20);

        System.out.println("Flight numbers before swapNumbers - val1:" +
                val1.getFlightNumber() + " val2:" + val2.getFlightNumber());

        swapNumbers(val1, val2);

        System.out.println("Flight numbers after swapNumbers - val1:" +
                val1.getFlightNumber() + " val2:" + val2.getFlightNumber());

        System.out.println("***************************");
        System.out.println("");
    }

    private static void overloading() {
        System.out.println("***************************");
        System.out.println("Overloading");
        System.out.println("");

        Flight f = new Flight();

        System.out.println("Calling f.add1Passenger()");
        f.add1Passenger();

        System.out.println();
        System.out.println("Calling f.add1Passenger(2)");
        f.add1Passenger(2);

        Passenger p1 =
                new Passenger(0, 1);
        System.out.println();
        System.out.println("Calling f.add1Passenger(p1)");
        f.add1Passenger(p1);

        Passenger p2 =
                new Passenger(0, 2);
        System.out.println();
        System.out.println("Calling f.add1Passenger(p2, 1)");
        f.add1Passenger(p2, 1);

        short threeBags = 3;
        System.out.println();
        System.out.println("Calling f.add1Passenger(threeBags, 2)");
        f.add1Passenger(threeBags, 2);

        System.out.println("***************************");
        System.out.println("");
    }

    private static void variableLengthParameterList() {
        System.out.println("***************************");
        System.out.println("Overloading");
        System.out.println("");

        Flight f = new Flight();

        Passenger luisa = new Passenger(0, 1);
        Passenger john = new Passenger(0, 2);
        System.out.println("Calling f.addPassengers(luisa, john)");
        f.addPassengers(luisa, john);

        Passenger harish = new Passenger(0, 2);
        Passenger julie = new Passenger(0, 2);
        Passenger ashanti = new Passenger(0, 0);
        System.out.println("");
        System.out.println("Calling f.addPassengers(harish, julie, ashanti)");
        f.addPassengers(harish, julie, ashanti);

        System.out.println("***************************");
        System.out.println("");
    }


    static void swapFlight(Flight i, Flight j) {
        Flight k = i;
        i = j;
        j = k;

        System.out.println("Flight numbers within swapFlight - i:" +
                i.getFlightNumber() + " j:" + j.getFlightNumber());
    }

    static void swapNumbers(Flight i, Flight j) {
        int k = i.getFlightNumber();
        i.setFlightNumber(j.getFlightNumber());
        j.setFlightNumber(k);

        System.out.println("Flight numbers within swapNumbers - i:" +
                i.getFlightNumber() + " j:" + j.getFlightNumber());
    }

}
