package com.pluralsight.slidesenums;

public class Main {

    public static void main(String[] args) {
        enumEquality();
        enumSwitchStatement();
        enumRelativeCompare();

    }

    private static void enumEquality() {
        System.out.println("***************************");
        System.out.println("Equality Checks with Enums");
        System.out.println();

        FlightCrewJob job1 = FlightCrewJob.PILOT;
        FlightCrewJob job2 = FlightCrewJob.FLIGHT_ATTENDANT;

        if(job1 == FlightCrewJob.PILOT)
            System.out.println("job1 is PILOT");

        if(job1 != job2)
            System.out.println("job1 and job2 are different");


        System.out.println("***************************");
        System.out.println();
    }

    private static void enumSwitchStatement() {
        System.out.println("***************************");
        System.out.println("Switch Statement with Enums");
        System.out.println();

        FlightCrewJob job1 = FlightCrewJob.PILOT;
        FlightCrewJob job2 = FlightCrewJob.FLIGHT_ATTENDANT;
        FlightCrewJob job3 = FlightCrewJob.COPILOT;

        System.out.println("Job responsibility for " + job1);
        displayJobResponsibilities(job1);

        System.out.println();
        System.out.println("Job responsibility for " + job2);
        displayJobResponsibilities(job2);

        System.out.println();
        System.out.println("Job responsibility for " + job3);
        displayJobResponsibilities(job3);

        System.out.println("***************************");
        System.out.println();
    }

    private static void displayJobResponsibilities(FlightCrewJob job) {
        switch(job) {
            case FLIGHT_ATTENDANT:
                System.out.println("Assures passenger safety");
                break;
            case COPILOT:
                System.out.println("Assists in flying the plane");
                break;
            case PILOT:
                System.out.println("Flies the plane");
                break;
        }
    }


    private static void enumRelativeCompare() {
        System.out.println("***************************");
        System.out.println("Relative Comparison of Enums");
        System.out.println();

        CrewMember geetha = new CrewMember(FlightCrewJob.PILOT, "Geetha");
        CrewMember bob = new CrewMember(FlightCrewJob.FLIGHT_ATTENDANT, "Bob");

        System.out.println("Comparing " + geetha.getName() + " who is a " + geetha.getJob() +
                " with " + bob.getName() + " who is a " + bob.getJob());

        whoIsInCharge(geetha, bob);

        System.out.println("***************************");
        System.out.println();
    }

    private static void whoIsInCharge(CrewMember member1, CrewMember member2) {
        CrewMember theBoss = member1.getJob().compareTo(member2.getJob()) > 0 ?
                member1 : member2;
        System.out.println(theBoss.getJob().getTitle() + " " + theBoss.getName() + " is in charge");
    }
}
