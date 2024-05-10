package com.pluralsight.slidesstaticmembers;

public class Main {

    public static void main(String[] args) {
	    staticFieldsMethodsAndInitializationBlocks();
    }

    private static void staticFieldsMethodsAndInitializationBlocks() {
        System.out.println("***************************");
        System.out.println("Using static fields, methods, and initialization blocks");
        System.out.println("");

        Flight.resetAllPassengers();

        Flight laxToSlc = new Flight();
        laxToSlc.add1Passenger();
        laxToSlc.add1Passenger();

        Flight dfwToNyc = new Flight();
        dfwToNyc.add1Passenger();

        System.out.println("laxToSlc: " + laxToSlc.getPassengers());
        System.out.println("dfwToNyc: " + dfwToNyc.getPassengers());
        System.out.println("Total: " + Flight.getAllPassengers());

        System.out.println("***************************");
        System.out.println("");
    }
}
