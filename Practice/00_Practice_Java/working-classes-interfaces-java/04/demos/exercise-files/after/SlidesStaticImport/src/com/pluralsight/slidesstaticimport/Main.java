package com.pluralsight.slidesstaticimport;

// Can use the following 2 static imports
import static com.pluralsight.slidesstaticimport.Flight.resetAllPassengers;
import static com.pluralsight.slidesstaticimport.Flight.getAllPassengers;

// Or just the following single import statement
//import static com.pluralsight.slidesstaticimport.Flight.*;

public class Main {

    public static void main(String[] args) {
        staticImports();
    }

    private static void staticImports() {
        System.out.println("***************************");
        System.out.println("Using static imports");
        System.out.println("");

        resetAllPassengers();

        Flight laxToSlc = new Flight();
        laxToSlc.add1Passenger();
        laxToSlc.add1Passenger();

        Flight dfwToNyc = new Flight();
        dfwToNyc.add1Passenger();

        System.out.println("laxToSlc: " + laxToSlc.getPassengers());
        System.out.println("dfwToNyc: " + dfwToNyc.getPassengers());
        System.out.println("Total: " + getAllPassengers());

        System.out.println("***************************");
        System.out.println("");

    }
}
