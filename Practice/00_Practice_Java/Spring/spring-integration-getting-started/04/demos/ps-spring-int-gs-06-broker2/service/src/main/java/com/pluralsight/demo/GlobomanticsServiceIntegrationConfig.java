package com.pluralsight.demo;

import com.pluralsight.demo.model.AttendeeRegistration;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.listener.AbstractMessageListenerContainer;
import org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.integration.amqp.inbound.AmqpInboundChannelAdapter;
import org.springframework.integration.annotation.Transformer;
import org.springframework.integration.channel.DirectChannel;
import org.springframework.integration.json.JsonToObjectTransformer;
import org.springframework.messaging.MessageChannel;

@Configuration
public class GlobomanticsServiceIntegrationConfig {

    /**
     * A {@link org.springframework.amqp.rabbit.listener.MessageListenerContainer MessageListenerContainer} to receive messages from RabbitMQ.
     * <p>
     * Spring Boot automatically configures a {@link ConnectionFactory} for RabbitMQ because {@code org.springframework.amqp:spring-amqp}
     * and {@code org.springframework.amqp:spring-rabbit} are on the classpath.
     *
     * @param connectionFactory Connection factory to connect with RabbitMQ.
     * @return An {@link AbstractMessageListenerContainer}.
     */
    @Bean
    public AbstractMessageListenerContainer messageListenerContainer(ConnectionFactory connectionFactory) {
        SimpleMessageListenerContainer messageListenerContainer = new SimpleMessageListenerContainer(connectionFactory);
        messageListenerContainer.setQueueNames("globomantics.registrationRequest");
        return messageListenerContainer;
    }

    /**
     * An inbound channel adapter that receives messages from RabbitMQ using a message listener container and puts them on a Spring Integration channel.
     *
     * @param messageListenerContainer The message listener container.
     * @return An {@link AmqpInboundChannelAdapter}.
     */
    @Bean
    public AmqpInboundChannelAdapter inboundChannelAdapter(AbstractMessageListenerContainer messageListenerContainer) {
        AmqpInboundChannelAdapter adapter = new AmqpInboundChannelAdapter(messageListenerContainer);
        adapter.setOutputChannelName("fromRabbit");
        return adapter;
    }

    @Bean
    public MessageChannel fromRabbit() {
        return new DirectChannel();
    }

    /**
     * A transformer that converts string containing JSON to an {@link AttendeeRegistration} object.
     * <p>
     * Note that the {@link Transformer @Transformer} annotation connects the transformer to input and output channels.
     *
     * @return A {@link JsonToObjectTransformer}.
     */
    @Bean
    @Transformer(inputChannel = "fromRabbit", outputChannel = "registrationRequest")
    public JsonToObjectTransformer jsonToObjectTransformer() {
        return new JsonToObjectTransformer(AttendeeRegistration.class);
    }

    @Bean
    public MessageChannel registrationRequest() {
        return new DirectChannel();
    }
}
