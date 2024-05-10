# Spring Integration: Getting Started - 05 - Message Broker

This is a demo project for the Pluralsight course "Spring Integration: Getting Started" by Jesper de Jong.

Demo 5: Splitting the demo into separate frontend and backend applications that use [RabbitMQ](https://www.rabbitmq.com/) for messaging.  

## Splitting frontend and backend

In this example, the project is a multi-module Maven project. There are three modules:

- `model` - Contains data transfer objects used by both the frontend and the backend.
- `web` - The frontend. A Spring Boot web application that sends messages to the backend via RabbitMQ, using Spring Integration.
- `service` - The backend. A Spring Boot application that uses Spring Integration to receive messages via RabbitMQ.

The frontend and backend are now two separate applications, that communicate via a RabbitMQ queue.

### Building

Build the application using one of the following commands:

    # macOS or Linux
    ./mvnw clean install

    # Windows
    mvnw.cmd clean install

(This will automatically download [Apache Maven](http://maven.apache.org/) if necessary).

### Running

#### RabbitMQ

To be able to run this version of the demo, you will need to have RabbitMQ running. An easy way to run RabbitMQ is by using [Docker](https://www.docker.com/).

To create and start RabbitMQ in a Docker container, use the following command:

    docker run -d -h rabbitmq --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.7-management-alpine

Some additional Docker commands:

    # Check what Docker containers are running
    docker ps

    # Stop the RabbitMQ container
    docker stop rabbitmq

    # Delete the RabbitMQ container (deletes all data in the container)
    docker rm rabbitmq

When RabbitMQ is running, its management interface is available at: http://localhost:15672

Login with username `guest` and password `guest`.

Before starting the demo application, go to "Queues" in the management interface and define a queue named: `globomantics.registrationRequest`

#### Frontend and backend

Run the frontend application with one of the following commands:

    # macOS or Linux
    ./mvnw -pl web spring-boot:run

    # Windows
    mvnw.cmd -pl web spring-boot:run

Or run the class `GlobomanticsWebApplication` from your IDE.

Run the backend application with one of the following commands:

    # macOS or Linux
    ./mvnw -pl service spring-boot:run

    # Windows
    mvnw.cmd -pl service spring-boot:run

Or run the class `GlobomanticsServiceApplication` from your IDE.

When the applications have started, point your browser to: http://localhost:8080

Select a ticket type, fill in the registration form and click the "Register" button.

Then go to the H2 Console at: http://localhost:8081/h2-console

(Note, it's now using port 8081; the frontend occupies port 8080).

Use JDBC URL: `jdbc:h2:mem:globomantics`, username: `sa`, and no password to connect to the in-memory H2 database.

You will see records in the tables `ATTENDEES` and `ATTENDEE_TICKETS`.
