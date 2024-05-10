package com.pluralsight.slidesflightbeforeaccessmodifiers;

class Flight {
    int passengers;
    int seats;
    Flight() {
        seats = 150;
        passengers = 0;
    }
    void add1Passenger() {
        if(passengers < seats)
            passengers += 1;
    }
}
