package com.pluralsight.demo;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.integration.channel.DirectChannel;
import org.springframework.messaging.MessageChannel;

@Configuration
public class GlobomanticsIntegrationConfig {

    @Bean
    public MessageChannel registrationRequest() {
        return new DirectChannel();
    }
}
