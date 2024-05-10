# Spring Integration: Getting Started - 07 - Scaling the Backend

This is a demo project for the Pluralsight course "Spring Integration: Getting Started" by Jesper de Jong.

Demo 7: Running multiple instances of the backend.

## Scaling the backend

One of the benefits of splitting the application into a separate frontend and backend is that they can scale independently. The purpose of this demo is to run one instance of the frontend and
two instances of the backend.

In the previous examples, we have used an in-memory H2 database in the backend. This would not be ideal when running multiple instances of the backend - each instance would have its own in-memory database.
Instead, we would like the backend instances to share a database. Therefore, we will run the H2 database in server mode, and have the backend instances connect to the H2 server.

For building the application, see the README in the previous examples.

### Running

#### RabbitMQ

To create and start RabbitMQ in a Docker container, use the following command:

    docker run -d -h rabbitmq --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.7-management-alpine

When RabbitMQ is running, its management interface is available at: http://localhost:15672

Login with username `guest` and password `guest`.

Before starting the demo application, go to "Queues" in the management interface and define a queue named: `globomantics.registrationRequest`

#### H2 Database in server mode

To start the H2 database in a Docker container, use the following command:

    docker run -d -p 8082:8082 -p 9092:9092 --name h2 jesperdj/h2

This uses a Docker image that I published on Docker Hub: https://hub.docker.com/r/jesperdj/h2

When it's running you can access the H2 console at: http://localhost:8082

Connect to the database with JDBC URL: `jdbc:h2:tcp://localhost/globomantics`, username `sa`, no password.

Make sure you create the schema and insert sample data by executing the SQL in the files `service/schema.sql` and `service/data.sql` before starting the backend application.

#### Frontend

Run the frontend application with one of the following commands:

    # macOS or Linux
    ./mvnw -pl web spring-boot:run

    # Windows
    mvnw.cmd -pl web spring-boot:run

Or run the class `GlobomanticsWebApplication` from your IDE.

#### Backend

Run multiple instances of the backend application by using one of the following commands multiple times:

    # macOS or Linux
    ./mvnw -pl service spring-boot:run

    # Windows
    mvnw.cmd -pl service spring-boot:run

Or run the class `GlobomanticsServiceApplication` from your IDE.
