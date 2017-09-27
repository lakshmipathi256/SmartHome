
package com.cdi.smarthome.config;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.converter.MessageConverter;
import org.springframework.messaging.handler.invocation.HandlerMethodArgumentResolver;
import org.springframework.messaging.handler.invocation.HandlerMethodReturnValueHandler;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketTransportRegistration;

/**
 * @author CDI server Team(Basappa and Lakshmi)
 * 
 * Defines methods for configuring message handling with simple messaging
 * protocols (e.g. STOMP) from WebSocket clients. Typically used to customize
 * the configuration provided via the {@link EnableWebSocketMessageBroker}
 * annotation. <br/>
 * <br/>
 * WebSocketConfig is annotated with <code>@Configuration</code> to indicate
 * that it is a Spring configuration class. It is also annotated with
 * <code>@EnableWebSocketMessageBroker</code>. As its name suggests,
 * <code>@EnableWebSocketMessageBroker</code> enables WebSocket message
 * handling, backed by a message broker. <br/>
 * <br/>
 * Furthermore, this is also annotated with the <code>@EnableScheduling</code>
 * annotation. This enables Spring's scheduled task execution ability.
 * 
 */

@Configuration
@EnableWebSocketMessageBroker
@EnableScheduling
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

	Logger logger= Logger.getLogger(WebSocketConfig.class);
    /**
     * Configure STOMP over WebSocket end-points.
     * 
     * @see com.blogspot.sunitkatkar.WebSocketBroadcastController.controllers.WebsocketBroadcastController
     */
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // The registerStompEndpoints() method registers the "/simplemessages"
        // endpoint, enabling SockJS fallback options so that alternative
        // messaging options may be used if WebSocket is not available. This
        // endpoint when prefixed with "/app", is the endpoint that the
        // WebSocketBroadcastController.processMessageFromClient() method is
        // mapped to handle.
        registry.addEndpoint("/simplemessages").withSockJS();
       
        logger.info("websocket connected");
    }

    /**
     * Configure message broker options.
     */
    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        // The configureMessageBroker() method overrides the default method in
        // WebSocketMessageBrokerConfigurer to configure the message broker. It
        // starts by calling enableSimpleBroker() to enable a simple
        // memory-based message broker to carry the greeting messages back to
        // the client on destinations prefixed with "/topic/". It also
        // designates the "/app" prefix for messages that are bound for
        // @MessageMapping-annotated methods.

        config.enableSimpleBroker("/topic/", "/queue/","/user");
        config.setApplicationDestinationPrefixes("/app");
    }

    /**
     * 
     * Configure the {@link org.springframework.messaging.MessageChannel} used
     * for incoming messages from WebSocket clients. By default the channel is
     * backed by a thread pool of size 1. It is recommended to customize thread
     * pool settings for production use.
     */
    @Override
    public void configureClientInboundChannel(ChannelRegistration registration) {

    }

    /**
     * Configure the {@link org.springframework.messaging.MessageChannel} used
     * for outgoing messages to WebSocket clients. By default the channel is
     * backed by a thread pool of size 1. It is recommended to customize thread
     * pool settings for production use.
     */
    @Override
    public void configureClientOutboundChannel(ChannelRegistration registration) {
        registration.taskExecutor().corePoolSize(4).maxPoolSize(10);
    }

	@Override
	public void configureWebSocketTransport(WebSocketTransportRegistration registry) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addReturnValueHandlers(List<HandlerMethodReturnValueHandler> returnValueHandlers) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean configureMessageConverters(List<MessageConverter> messageConverters) {
		// TODO Auto-generated method stub
		return false;
	}

}
