package com.pluralsight.slidesenums;

public class CrewMember {
    private FlightCrewJob job;
    private String name;

    public CrewMember() {}

    public CrewMember(FlightCrewJob job, String name) {
        this.job = job;
        this.name = name;
    }

    public FlightCrewJob getJob() {
        return job;
    }

    public void setJob(FlightCrewJob job) {
        this.job = job;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
