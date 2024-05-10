package com.pluralsight.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ImportResource;

@SpringBootApplication
@ImportResource("classpath:/web-integration-config.xml")
public class GlobomanticsWebApplication {

    public static void main(String[] args) {
        SpringApplication.run(GlobomanticsWebApplication.class, args);
    }
}
