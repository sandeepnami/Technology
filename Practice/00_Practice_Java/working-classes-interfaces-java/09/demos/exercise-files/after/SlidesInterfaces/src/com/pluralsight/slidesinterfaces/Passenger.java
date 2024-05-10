package com.pluralsight.slidesinterfaces;

public class Passenger implements Comparable<Passenger> {
    private int memberLevel; // 3 (1st priority), 2, 1
    private int memberDays;

    private String name;

    private int checkedBags;
    private int freeBags;
    private double perBagFee;

    public Passenger() { }

    public Passenger(String name) {
        this.name = name;
    }

    public Passenger(String name, int memberLevel, int memberDays) {
        this(name);
        this.memberLevel = memberLevel;
        this.memberDays = memberDays;
    }

    public Passenger(int freeBags) {
        this(freeBags > 1 ? 25.0d : 50.0d);
        this.freeBags = freeBags;
    }

    public Passenger(int freeBags, int checkedBags) {
        this(freeBags);
        this.checkedBags = checkedBags;
    }

    private Passenger(double perBagFee) {
        this.perBagFee = perBagFee;
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

    public int getMemberLevel() {
        return memberLevel;
    }

    public int getMemberDays() {
        return memberDays;
    }

    public void setLevelAndDays(int memberLevel, int memberDays) {
        this.memberLevel = memberLevel;
        this.memberDays = memberDays;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public int compareTo(Passenger p) {
            int returnValue = p.memberLevel - memberLevel;
        if(returnValue == 0)
            returnValue = p.memberDays - memberDays;

        // Set showComparisonInfo to false to stop displaying comparison details
        boolean showComparisonInfo = true;
        if(showComparisonInfo) {
            System.out.println("Comparing " + getName() + " to " + p.getName());
            System.out.println("     Current | name: " + getName() + " | level: " + getMemberLevel() +
                    " | member days: " + getMemberDays());
            System.out.println("     Received | name: " + p.getName() + " | level: " + p.getMemberLevel() +
                    " | member days: " + p.getMemberDays());
            System.out.println("     returnValue: " + returnValue);

        }
        return returnValue;
    }
}
