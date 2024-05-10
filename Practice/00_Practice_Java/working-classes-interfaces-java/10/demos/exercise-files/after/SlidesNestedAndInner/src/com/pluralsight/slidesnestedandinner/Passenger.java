package com.pluralsight.slidesnestedandinner;

public class Passenger implements Comparable<Passenger> {
    private String name;

    public static class RewardProgram {
        private int memberLevel; // 3 (1st priority), 2, 1
        private int memberDays;

        public int getMemberLevel() {
            return memberLevel;
        }
        public void setMemberLevel(int memberLevel) {
            this.memberLevel = memberLevel;
        }

        public int getMemberDays() {
            return memberDays;
        }
        public void setMemberDays(int memberDays) {
            this.memberDays = memberDays;
        }
    }

    public RewardProgram getRewardProgram() {
        return rewardProgram;
    }

    private RewardProgram rewardProgram = new RewardProgram();

    private int checkedBags;
    private int freeBags;
    private double perBagFee;

    public Passenger() { }

    public Passenger(String name) {
        this.name = name;
    }

    public Passenger(String name, int memberLevel, int memberDays) {
        this(name);
        rewardProgram.memberLevel = memberLevel;
        rewardProgram.memberDays = memberDays;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public int compareTo(Passenger p) {
            int returnValue = p.rewardProgram.memberLevel - rewardProgram.memberLevel;
        if(returnValue == 0)
            returnValue = p.rewardProgram.memberDays - rewardProgram.memberDays;
        return returnValue;
    }
}
