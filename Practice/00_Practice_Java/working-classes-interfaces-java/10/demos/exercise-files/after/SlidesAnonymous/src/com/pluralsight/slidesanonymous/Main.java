package com.pluralsight.slidesanonymous;

public class Main {

    public static void main(String[] args) {
	    anonymousClass();
    }

    private static void anonymousClass() {
        System.out.println("***************************");
        System.out.println("Anonymous Class");
        System.out.println();

        Flight f175 = new Flight(175);
        f175.add1Passenger(new Passenger("Luisa", 1, 180));
        f175.add1Passenger(new Passenger("Jack", 1, 90));
        f175.add1Passenger(new Passenger("Ashanti", 3, 730));
        f175.add1Passenger(new Passenger("Harish", 2, 150));

        System.out.println(" ** Passenger order using Flight class' Iterable implementation **");
        for(Passenger p : f175)
            System.out.println(p.getName());

        System.out.println();
        System.out.println(" ** Passenger order using the anonymous class' Iterable implementation **");
        for(Passenger p : f175.getOrderedPassengers())
            System.out.println(p.getName());

        System.out.println("***************************");
        System.out.println();
    }

}
