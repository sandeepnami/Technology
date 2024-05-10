package com.pluralsight.slidesinterfaces;

import java.util.Arrays;

public class Main {

    public static void main(String[] args) {
        comparable();
        flightWithIterator();
    }

    private static void comparable() {
        System.out.println("***************************");
        System.out.println("Sorting Passenger array with Comparable");
        System.out.println();

        Passenger[] passengers = {
                new Passenger("Luisa", 1, 180),
                new Passenger("Jack", 1, 90),
                new Passenger("Ashanti", 3, 730),
                new Passenger("Harish", 2, 150),
        };

        Arrays.sort(passengers);

        System.out.println();
        System.out.println("Passengers after sort");
        for (Passenger p : passengers) {
            System.out.println("Passenger name: " + p.getName() + " level: " + p.getMemberLevel() +
                    " member days: " + p.getMemberDays());
        }

        System.out.println("***************************");
        System.out.println();
    }

    private static void flightWithIterator() {
        System.out.println("***************************");
        System.out.println("For-each through Flight Passenger list with Iterable");
        System.out.println();

        Flight f175 = new Flight(175);
        f175.add1Passenger(new Passenger("Santiago"));
        f175.add1Passenger(new Passenger("Julie"));
        f175.add1Passenger(new Passenger("John"));
        f175.add1Passenger(new Passenger("Geetha"));
        for (Passenger p : f175) {
            System.out.println("Passenger name: " + p.getName());
        }

        System.out.println("***************************");
        System.out.println();
    }
}