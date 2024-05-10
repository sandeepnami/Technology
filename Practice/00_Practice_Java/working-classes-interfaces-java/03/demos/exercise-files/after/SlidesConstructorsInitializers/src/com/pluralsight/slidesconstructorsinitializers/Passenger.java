package com.pluralsight.slidesconstructorsinitializers;

public class Passenger {
    private int checkedBags;
    private int freeBags;
    private double perBagFee;

    public Passenger() {
        System.out.println("executing Passenger()");
    }

    public Passenger(int freeBags) {
        this(freeBags > 1 ? 25.0d : 50.0d);
        this.freeBags = freeBags;
        System.out.println("executing Passenger(int freeBags)");
    }

    public Passenger(int freeBags, int checkedBags) {
        this(freeBags);
        this.checkedBags = checkedBags;
        System.out.println("executing Passenger(int freeBags, int checkedBags)");
    }

    private Passenger(double perBagFee) {
        this.perBagFee = perBagFee;
        System.out.println("executing Passenger(double perBagFee)");
    }

    public int getCheckedBags() {
        return checkedBags;
    }

    public void setCheckedBags(int checkedBags) {
        this.checkedBags = checkedBags;
    }

    public int getFreeBags() {
        return freeBags;
    }

    public void setFreeBags(int freeBags) {
        this.freeBags = freeBags;
    }

}
