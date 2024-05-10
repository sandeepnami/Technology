package com.pluralsight.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ImportResource;

@SpringBootApplication
@ImportResource("classpath:/integration-config.xml")
public class GlobomanticsRegistrationApplication {

    public static void main(String[] args) {
        SpringApplication.run(GlobomanticsRegistrationApplication.class, args);
    }
}
