# Spring Integration: Getting Started - 08 - Publish-Subscribe Messaging

This is a demo project for the Pluralsight course "Spring Integration: Getting Started" by Jesper de Jong.

Demo 8: Publish-subscribe messaging.

## Publish-subscribe messaging

In this version of the demo, we have added a publish-subscribe queue to broadcast registration event messages.

When a registration is made, the `RegistrationService` returns a `RegistrationEvent` object which is published on a publish-subscribe channel. Two components are subscribed to this channel: an outbound channel adapter
that will send a confirmation email to the attendee, and an outbound channel adapter that will call a billing webservice.

There are four modules:

- `model` - Contains data transfer objects used by both the frontend and the backend.
- `web` - The frontend. A Spring Boot web application that sends messages to the backend via RabbitMQ, using Spring Integration.
- `service` - The backend. A Spring Boot application that uses Spring Integration to receive messages via RabbitMQ.
- `billing` - A minimal Spring Boot application with a REST webservice that represents the billing system.

The H2 database is now back to an in-memory database in the backend, so we don't need to run H2 in a Docker container anymore.

We do need a mail server - we'll run [GreenMail](http://www.icegreen.com/greenmail/) in a Docker container.

For building the application, see the README in the previous examples.

### Running

#### RabbitMQ

To create and start RabbitMQ in a Docker container, use the following command:

    docker run -d -h rabbitmq --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.7-management-alpine

When RabbitMQ is running, its management interface is available at: http://localhost:15672

Login with username `guest` and password `guest`.

Before starting the demo application, go to "Queues" in the management interface and define a queue named: `globomantics.registrationRequest`

#### GreenMail

[GreenMail](http://www.icegreen.com/greenmail/) is a simple mail server for testing purposes.

To start GreenMail in a Docker container:

    docker run -d -h greenmail --name greenmail -p 3025:3025 -p 3143:3143 greenmail/standalone

Port 3025 is for sending mail (SMTP); port 3143 is for receiving mail (IMAP).

You can inspect the IMAP inbox using the `curl` command:

    # Check the status of the inbox
    curl --url "imap://localhost:3143" --user "joe@example.com:joe@example.com" --request "EXAMINE INBOX"

    # Read email with UID 1
    curl --url "imap://localhost:3143/INBOX;UID=1" --user "joe@example.com:joe@example.com"

Where `"joe@example.com:joe@example.com"` are the username and password of the mailbox you want to inspect.
GreenMail automatically creates a mailbox with the email address of the receiver as the username and password whenever an email is sent.

#### Billing

Run the billing webservice with one of the following commands:

    # macOS or Linux
    ./mvnw -pl billing spring-boot:run

    # Windows
    mvnw.cmd -pl billing spring-boot:run

Or run the class `GlobomanticsBillingApplication` from your IDE.

The billing webservice will listen on port 8083.

#### Frontend

Run the frontend application with one of the following commands:

    # macOS or Linux
    ./mvnw -pl web spring-boot:run

    # Windows
    mvnw.cmd -pl web spring-boot:run

Or run the class `GlobomanticsWebApplication` from your IDE.

#### Backend

Run the backend application with one the following commands:

    # macOS or Linux
    ./mvnw -pl service spring-boot:run

    # Windows
    mvnw.cmd -pl service spring-boot:run

Or run the class `GlobomanticsServiceApplication` from your IDE.

When it's running, look at the database using the H2 Console at: http://localhost:8081/h2-console

Use JDBC URL: `jdbc:h2:mem:globomantics`, username: `sa`, and no password to connect to the in-memory H2 database.
