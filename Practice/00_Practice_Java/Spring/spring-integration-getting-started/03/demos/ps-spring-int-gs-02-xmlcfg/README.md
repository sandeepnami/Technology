# Spring Integration: Getting Started - 02 - XML Config

This is a demo project for the Pluralsight course "Spring Integration: Getting Started" by Jesper de Jong.

Demo 2: Introducing Spring Integration using XML configuration.

## Introducing Spring Integration

In this demo we're adding Spring Integration to the project.

In the Maven `pom.xml`, we have added a dependency on `org.springframework.boot:spring-boot-starter-integration`. This is the Spring Boot starter for Spring Integration, which will add the necessary dependencies and
Spring Boot auto-configuration for Spring Integration.

We have also added a Spring Integration XML configuration file: `src/main/resources/integration-config.xml`. On class `GlobomanticsRegistrationApplication` we have added an `@ImportResource` annotation to load the
XML configuration file.

The controller in the web layer, in class `RegistrationController`, now does not have a direct dependency on class `RegistrationService` in the service layer anymore - instead, it sends messages to the service layer
using a Spring Integration message channel.

You can find more information on Spring Integration, including the reference and API documentation, at: https://spring.io/projects/spring-integration

### Building

Build the application using one of the following commands:

    # macOS or Linux
    ./mvnw clean install

    # Windows
    mvnw.cmd clean install

(This will automatically download [Apache Maven](http://maven.apache.org/) if necessary).

### Running

Run the application using one of the following commands:

    # macOS or Linux
    ./mvnw spring-boot:run

    # Windows
    mvnw.cmd spring-boot:run

Or run the class `GlobomanticsRegistrationApplication` from your IDE.

When the application has started, point your browser to: http://localhost:8080

Select a ticket type, fill in the registration form and click the "Register" button.

Then go to the H2 Console at: http://localhost:8080/h2-console

Use JDBC URL: `jdbc:h2:mem:globomantics`, username: `sa`, and no password to connect to the in-memory H2 database.

You will see records in the tables `ATTENDEES` and `ATTENDEE_TICKETS`.
