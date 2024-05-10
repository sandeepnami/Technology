# Spring Integration: Getting Started - 03 - Java Config

This is a demo project for the Pluralsight course "Spring Integration: Getting Started" by Jesper de Jong.

Demo 3: Introducing Spring Integration using Java configuration.

## Introducing Spring Integration

In this demo we're adding Spring Integration to the project.

In this example, we are using Java configuration instead of XML configuration.

The Spring Integration components are defined in a Spring `@Configuration` class, named `GlobomanticsIntegrationConfig`. There, we are defining the message channel using a `@Bean` method.

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
