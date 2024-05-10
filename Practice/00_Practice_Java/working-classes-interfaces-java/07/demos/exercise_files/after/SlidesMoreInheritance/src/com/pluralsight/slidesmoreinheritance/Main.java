package com.pluralsight.slidesmoreinheritance;

public class Main {

    public static void main(String[] args) {
	    useEqualsWithSuper();
	    inheritanceAndConstructors();
    }

    private static void useEqualsWithSuper() {
        System.out.println("***************************");
        System.out.println("Equals with Super");
        System.out.println();

        Flight f1 = new Flight(175);
        Flight f2 = f1;

        // do some other stuff

        System.out.println("Calling f1.equals(f2)");
        if(f1.equals(f2))
            System.out.println("f1.equals(f2) returns true");

        System.out.println("***************************");
        System.out.println();
    }

    private static void inheritanceAndConstructors() {
        System.out.println("***************************");
        System.out.println("Inheritance and Constructors");
        System.out.println();

        System.out.println("Creating - Flight f175");
        Flight f175 = new Flight(175);

        System.out.println();
        System.out.println("Creating - CargoFlight cf");
        CargoFlight cf = new CargoFlight();

        System.out.println();
        System.out.println("Creating - CargoFlight cf294");
        CargoFlight cf294 = new CargoFlight(294);

        System.out.println();
        System.out.println("Creating - CargoFlight cf85");
        CargoFlight cf85 = new CargoFlight(85, 2000.0f);

        System.out.println();
        System.out.println("Creating - CargoFlight cfBig");
        CargoFlight cfBig = new CargoFlight(5000.0f);

        System.out.println("***************************");
        System.out.println();
    }
}
