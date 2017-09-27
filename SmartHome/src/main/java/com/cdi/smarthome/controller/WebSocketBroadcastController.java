
package com.cdi.smarthome.controller;

import java.security.Principal;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageExceptionHandler;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;

import com.cdi.smarthome.model.MessageBroadcast;
import com.cdi.smarthome.model.SimpleMessage;
import com.cdi.smarthome.model.Util;

/**
 * @author CDI server Team(Basappa and Lakshmi)
 * 
 *         {@link WebSocketBroadcastController} is a regular Spring Controller
 *         as seen in most Spring MVC applications. Its job is to receive
 *         {@link SimpleMessage} message objects from the client, extract the
 *         <code>payload</code> (or contents) of the message, prepend it with
 *         some simple text and finally broadcast (or publish) the message to
 *         all clients who have subscribed to the
 *         <code>/topic/simplemessages</code> message queue.
 * 
 * 
 */

@Controller
public class WebSocketBroadcastController {
	
	@Autowired
	private PublisherController publishcontroller;

	private static final Logger LOG = LoggerFactory.getLogger(WebSocketBroadcastController.class);

	/**
	 * Method to handle the requests sent to this controller at
	 * <code>/simplemessages</code> <br/>
	 * <br/>
	 * <b>Explanation:</b> The <code>@MessageMapping</code> annotation ensures
	 * that if a message is sent to destination <code>/simplemessages</code>,
	 * then the
	 * {@link WebSocketBroadcastController#processMessageFromClient(SimpleMessage)}
	 * method is called. <br/>
	 * <br/>
	 * The message payload is bound to the {@link SimpleMessage} object. For
	 * simplicity, this method simulates a 3 second delay before sending back
	 * the message as a {@link MessageBroadcast} object. The return value is
	 * broadcast to all subscribers to
	 * <code>/topic/simplemessagesresponse</code> as specified in the
	 * <code>@SendTo</code> annotation. <br/>
	 * <br/>
	 * <b>Note:</b> The 3 second delay demonstrates that after the server
	 * receives a message from the client, the client is free to continue any
	 * other processing while the server takes its own time to act on the
	 * received message.
	 * 
	 * @param message
	 * @param principal
	 * @param locale
	 * @return
	 * @throws Exception
	 */
	@MessageMapping("/simplemessages")
	@SendTo("/topic/simplemessagesresponse")
	public MessageBroadcast processMessageFromClient(SimpleMessage message, Principal principal) throws Exception {
		LOG.info("Sending server side response '{}' for user: {}", message, principal.getName());
		return new MessageBroadcast("Server response: Did you send &lt;b&gt;'" + message.getMessage()
				+ "'&lt;/b&gt;? (Server Response at: " + Util.getSimpleDate() + ")");
	}

	@MessageMapping("/tempsub")
	public void processMessageFromClientToTemp(SimpleMessage message, Principal principal) throws Exception {
		LOG.info("Sending server side response LED control'{}' for user: {}", message, principal.getName());
		//subscriberController.TempSubscribe(principal);

	}

	@MessageMapping("/rfidsub")
	public void processMessageFromClientToRFID(SimpleMessage message,Principal principal) throws Exception {

		LOG.info("Sending server side response LED control'{}' for user: {}");
		//subscriberController.RFIDSubscribe(principal);

	}

	@MessageMapping("/LedON")
	public void ledMessageToGatewayON(SimpleMessage message,Principal principal) {
		publishcontroller.LEDOn(message.getMessage().toString());
		//subscriberController.LEDonSubscribe(principal);
	}

	@MessageMapping("/LedOFF")
	public void ledMessageToGatewayOFF(SimpleMessage message,Principal principal) {
		publishcontroller.LEDOff(message.getMessage().toString());
		//subscriberController.LEDoffSubscribe(principal);
	}

	/**
	 * If there are any exceptions thrown by any of the messaging infrastructure
	 * then they can be sent to the end user on the <code>/queue/errors</code>
	 * destination.
	 * 
	 */
	@MessageExceptionHandler
	@SendToUser("/queue/errors")
	public String handleException(Throwable exception) {
		
		LOG.info(exception.getMessage());
		
		return exception.getMessage();
	}

}