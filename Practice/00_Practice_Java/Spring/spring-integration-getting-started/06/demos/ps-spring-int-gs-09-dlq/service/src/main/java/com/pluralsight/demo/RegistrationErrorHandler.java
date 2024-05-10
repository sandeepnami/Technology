package com.pluralsight.demo;

import org.springframework.amqp.AmqpRejectAndDontRequeueException;
import org.springframework.stereotype.Component;
import org.springframework.util.ErrorHandler;

@Component
public class RegistrationErrorHandler implements ErrorHandler {

    @Override
    public void handleError(Throwable t) {
        throw new AmqpRejectAndDontRequeueException(t);
    }
}
