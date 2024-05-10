package com.pluralsight.demo.model;

import java.math.BigDecimal;

public class RegistrationEvent {

    private String ticketType;

    private BigDecimal ticketPrice;

    private String ticketCode;

    private String attendeeFirstName;

    private String attendeeLastName;

    private String attendeeEmail;

    public String getTicketType() {
        return ticketType;
    }

    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }

    public BigDecimal getTicketPrice() {
        return ticketPrice;
    }

    public void setTicketPrice(BigDecimal ticketPrice) {
        this.ticketPrice = ticketPrice;
    }

    public String getTicketCode() {
        return ticketCode;
    }

    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }

    public String getAttendeeFirstName() {
        return attendeeFirstName;
    }

    public void setAttendeeFirstName(String attendeeFirstName) {
        this.attendeeFirstName = attendeeFirstName;
    }

    public String getAttendeeLastName() {
        return attendeeLastName;
    }

    public void setAttendeeLastName(String attendeeLastName) {
        this.attendeeLastName = attendeeLastName;
    }

    public String getAttendeeEmail() {
        return attendeeEmail;
    }

    public void setAttendeeEmail(String attendeeEmail) {
        this.attendeeEmail = attendeeEmail;
    }
}
