package com.pluralsight.demo;

import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.integration.amqp.outbound.AmqpOutboundEndpoint;
import org.springframework.integration.annotation.Transformer;
import org.springframework.integration.channel.DirectChannel;
import org.springframework.integration.endpoint.EventDrivenConsumer;
import org.springframework.integration.json.ObjectToJsonTransformer;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageHandler;
import org.springframework.messaging.SubscribableChannel;

@Configuration
public class GlobomanticsWebIntegrationConfig {

    @Bean
    public MessageChannel registrationRequest() {
        return new DirectChannel();
    }

    /**
     * A transformer that converts Java objects to JSON.
     * <p>
     * Note that the {@link Transformer @Transformer} annotation connects the transformer to input and output channels.
     *
     * @return An {@link ObjectToJsonTransformer}.
     */
    @Bean
    @Transformer(inputChannel = "registrationRequest", outputChannel = "toRabbit")
    public ObjectToJsonTransformer objectToJsonTransformer() {
        return new ObjectToJsonTransformer();
    }

    @Bean
    public SubscribableChannel toRabbit() {
        return new DirectChannel();
    }

    /**
     * An event-driven consumer that receives messages from a {@link SubscribableChannel} and passes them to a message handler.
     * <p>
     * The message handler is in this case the {@link AmqpOutboundEndpoint} that sends messages to RabbitMQ.
     * <p>
     * Together the event-driven consumer and message handler represent the outbound channel adapter.
     * <p>
     * Note that if the input channel is a {@link org.springframework.messaging.PollableChannel PollableChannel},
     * you would have to use a {@link org.springframework.integration.endpoint.PollingConsumer PollingConsumer} here instead,
     * with an approprate polling configuration.
     *
     * @param channel Input channel.
     * @param handler Message handler.
     * @return An {@link EventDrivenConsumer}.
     */
    @Bean
    public EventDrivenConsumer rabbitConsumer(@Qualifier("toRabbit") SubscribableChannel channel, @Qualifier("rabbitOutboundEndpoint") MessageHandler handler) {
        return new EventDrivenConsumer(channel, handler);
    }

    /**
     * An endpoint that sends messages to an AMQP message broker using the given {@link AmqpTemplate}.
     * <p>
     * Spring Boot automatically configures a template for RabbitMQ because {@code org.springframework.amqp:spring-amqp}
     * and {@code org.springframework.amqp:spring-rabbit} are on the classpath.
     *
     * @param amqpTemplate {@link AmqpTemplate} to use to connect to the message broker.
     * @return An {@link AmqpOutboundEndpoint}.
     */
    @Bean
    public AmqpOutboundEndpoint rabbitOutboundEndpoint(AmqpTemplate amqpTemplate) {
        AmqpOutboundEndpoint adapter = new AmqpOutboundEndpoint(amqpTemplate);
        adapter.setRoutingKey("globomantics.registrationRequest");
        return adapter;
    }
}
