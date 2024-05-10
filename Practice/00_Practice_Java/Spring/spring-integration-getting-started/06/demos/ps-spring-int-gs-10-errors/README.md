# Spring Integration: Getting Started - 10 - Handling Errors

This is a demo project for the Pluralsight course "Spring Integration: Getting Started" by Jesper de Jong.

Demo 10: Handling errors using Spring Integration's error channel.

## Spring Integration error handling

When you use message channels that don't run their message handlers on the same thread as the sender, Spring Integration cannot pass exceptions directly to the sender of the message. What happens in that case is
that the original message along with the exception that occurred, is packaged in an `ErrorMessage` that's sent to a predefined message channel named `errorChannel`.

You can subscribe listeners to the `errorChannel` to handle errors.

In this example, we have configured the `fromRabbit` channel in the backend as an `ExecutorChannel` instead of a `DirectChannel`. An `ExecutorChannel` runs its message handlers on threads from a thread pool instead
of on the thread of the message sender.

For building the application, see the README in the previous examples.

### Running

#### RabbitMQ

To create and start RabbitMQ in a Docker container, use the following command:

    docker run -d -h rabbitmq --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.7-management-alpine

When RabbitMQ is running, its management interface is available at: http://localhost:15672

Login with username `guest` and password `guest`.

Before starting the demo application, go to "Queues" in the management interface and define a queue named: `globomantics.registrationRequest`

#### GreenMail

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
