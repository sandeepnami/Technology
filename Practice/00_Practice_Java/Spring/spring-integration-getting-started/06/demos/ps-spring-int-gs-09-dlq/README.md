# Spring Integration: Getting Started - 09 - Dead Letter Queue

This is a demo project for the Pluralsight course "Spring Integration: Getting Started" by Jesper de Jong.

Demo 9: Using a Dead Letter Queue.

## Dead Letter Queue

When an error occurs, the application can either tell RabbitMQ to requeue the message, or tell it to handle the message in a different way, for example by sending it to a dead letter queue.

In this example we set up an error handler, class `RegistrationErrorHandler`, on the AMQP inbound channel adapter to tell RabbitMQ to not requeue the message when an exception occurs.

By default, RabbitMQ will silently drop messages that are not requeued. But we can also create a dead letter exchange and queue and have RabbitMQ send messages that cannot be handled to that special queue
for examination by, for example, a system administrator.

For building the application, see the README in the previous examples.

### Running

#### RabbitMQ

To create and start RabbitMQ in a Docker container, use the following command:

    docker run -d -h rabbitmq --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.7-management-alpine

When RabbitMQ is running, its management interface is available at: http://localhost:15672

Login with username `guest` and password `guest`.

Create a dead letter exchange:

- Go to "Exchanges".
- Under "Add a new exchange", enter the name: "globomantics.dlx".
- Select "Type: fanout".
- Click "Add exchange".

Create a dead letter queue:

- Go to "Queues".
- Under "Add a new queue", enter the name: "globomantics.dlq".
- Click "Add queue".
- Then click on the name of the queue in the table.
- Under "Bindings" and "Add a binding to this queue", enter the name of the exchange, which is "globomantics.dlx" and click "Bind".

Create the registration request queue and configure it to use the dead letter exchange:

- Go to "Queues".
- Under "Add a new queue", enter the name: "globomantics.registrationRequest".
- Then click on "Dead letter exchange", which will add an argument.
- For the value of the argument, enter "globomantics.dlx", which is the name of the dead letter exchange.
- Click "Add queue".

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
