package com.pluralsight.slidesnestedandinner;

public class Main {

    public static void main(String[] args) {
        nestedType();
        innerClass();
    }

    private static void nestedType() {
        System.out.println("***************************");
        System.out.println("Nested Class - Passenger.RewardProgram");
        System.out.println();

        Passenger steve = new Passenger("Steve", 3, 180);

        Passenger.RewardProgram platinum = new Passenger.RewardProgram();
        platinum.setMemberLevel(3);

        if(steve.getRewardProgram().getMemberLevel() == platinum.getMemberLevel())
            System.out.println("Steve is platinum");

        System.out.println("***************************");
        System.out.println();
    }

    private static void innerClass() {
        System.out.println("***************************");
        System.out.println("Inner Class - Flight.FlightIterable");
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
        System.out.println(" ** Passenger order using FlightIterable class' Iterable implementation **");
        for(Passenger p : f175.getOrderedPassengers())
            System.out.println(p.getName());

        System.out.println("***************************");
        System.out.println();
    }

}
