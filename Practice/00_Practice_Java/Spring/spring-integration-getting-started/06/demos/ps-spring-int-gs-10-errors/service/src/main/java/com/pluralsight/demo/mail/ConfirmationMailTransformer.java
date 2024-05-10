package com.pluralsight.demo.mail;

import com.pluralsight.demo.model.RegistrationEvent;
import org.springframework.stereotype.Component;

@Component
public class ConfirmationMailTransformer {

    public String toMailText(RegistrationEvent event) {
        return "Dear " + event.getAttendeeFirstName() + " " + event.getAttendeeLastName() + ",\n\n" +
                "Thank you for registering for the Globomantics Tech Conference. We are looking forward to meeting you!\n\n" +
                "Your ticket code is: " + event.getTicketType() + "-" + event.getTicketCode() + "\n\n" +
                "Sincerely,\n\n" +
                "Globomantics Registration Team (registration@globomantics.com)";
    }
}
