package com.pluralsight.demo.billing;

import com.pluralsight.demo.model.RegistrationEvent;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class BillingController {
    private static final Logger LOG = LoggerFactory.getLogger(BillingController.class);

    @PostMapping
    public void post(@RequestBody RegistrationEvent event) {
        LOG.info("Billing request received for amount: {}", event.getTicketPrice());
    }
}
