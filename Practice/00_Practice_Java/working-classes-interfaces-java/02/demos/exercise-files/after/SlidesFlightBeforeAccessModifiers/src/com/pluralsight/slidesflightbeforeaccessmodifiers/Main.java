package com.pluralsight.slidesflightbeforeaccessmodifiers;

public class Main {

    public static void main(String[] args) {
	    usingClasses();
	    classesAsReferenceTypes();
    }

    private static void usingClasses() {
        System.out.println("***************************");
        System.out.println("Using Classes");
        System.out.println("");

        Flight nycToLv;
        nycToLv = new Flight();
        Flight slcToSf = new Flight();
        System.out.println("nycToLv - passengers: " + nycToLv.passengers + "  seats: " + nycToLv.seats);
        System.out.println("slcToSf - passengers: " + slcToSf.passengers + "  seats: " + slcToSf.seats);

        System.out.println("***************************");
        System.out.println("");
    }

    private static void classesAsReferenceTypes() {
        System.out.println("***************************");
        System.out.println("Understanding Classes as Reference Types");
        System.out.println("");

        Flight flight1 = new Flight();
        Flight flight2 = new Flight();
        flight2.add1Passenger();
        System.out.println(flight2.passengers); // 1
        flight2 = flight1;
        System.out.println(flight2.passengers); // 0
        flight1.add1Passenger();
        flight1.add1Passenger();
        System.out.println(flight2.passengers); // 2
        System.out.println("***************************");
        System.out.println("");
    }


}
