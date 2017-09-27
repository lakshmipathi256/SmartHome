package com.cdi.smarthome.controller;

import java.security.Principal;

import org.apache.log4j.Logger;
import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.cdi.smarthome.config.MQTTConnection;
import com.cdi.smarthome.model.MessageBroadcast;
import com.cdi.smarthome.service.UserService;

/*
 * @author CDI server Team(Basappa and Lakshmi)
 * This is a SubscriberController implements MqttCallback to connect with MQTT broker
 * We are using MqttClient class for connection purpose  
 * 
*/
@Controller
public class SubscriberController implements MqttCallback {
	final Logger logger = Logger.getLogger(SubscriberController.class);
	MqttClient client;
	@Autowired
	WebSocketBroadcastController broadcastController;
	@Autowired
	private SimpMessagingTemplate template;
	@Autowired
	private UserService userService;

	public static Float dataToAWS;

	public void RFIDSubscribe(Principal principal) {
		try {
			client = MQTTConnection.getInstance();
			client.setCallback(this);
			client.subscribe("/" + principal.getName() + "/Rfid");
           System.out.println("/" + principal.getName() + "/Rfid");
		} catch (MqttException e) {
			e.printStackTrace();
		}
	}

	public void TempSubscribe(Principal principal) {
		try {
			client = MQTTConnection.getInstance();
			client.setCallback(this);
			client.subscribe("/" + principal.getName() + "/Temp");

		} catch (MqttException e) {
			e.printStackTrace();
		}
	}

	public void LEDonSubscribe(Principal principal) {
		try {
			client = MQTTConnection.getInstance();
			client.setCallback(this);
			client.subscribe("/" + principal.getName() + "/ON");
		} catch (MqttException e) {
			e.printStackTrace();
		}
	}

	public void LEDoffSubscribe(Principal principal) {
		try {
			client = MQTTConnection.getInstance();
			client.setCallback(this);
			client.subscribe("/" + principal.getName() + "/OFF");
		} catch (MqttException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void connectionLost(Throwable cause) {
		System.err.println("Connection lost in MQTT");
	}

	@Override
	public void messageArrived(String topic, MqttMessage message) throws Exception {
		logger.info("Message is received from " + topic + " and message is :" + message);
		MessageBroadcast msg = new MessageBroadcast();
		msg.setMessageContent(message.toString());
		msg.setDirection("gateWayToClient");
		msg.setTopic(topic);
		userService.saveGatewayData(msg);
		//String username=new String(topic);
	    String[] userName=(new String(topic)).split("/");
	
		

		if (topic.equals("/" + userName[1] + "/Temp")) {
			dataToAWS = Float.parseFloat(message.toString());

			logger.info("temperature message is sending to /" + userName[1] + "/user");

			this.template.convertAndSendToUser(userName[1], "/tempsub", msg.getMessageContent());
		} else if (topic.equals("/" + userName[1] + "/Rfid")) {

			logger.info("RFID Data is sending to /" + userName[1] + "/user");

			this.template.convertAndSendToUser(userName[1], "/rfidsub", msg.getMessageContent());
		} else if (topic.equals("/" + userName[1] + "/ON")) {

			logger.info("light status is sending to /" + userName[1] + "/user");

			this.template.convertAndSendToUser(userName[1], "/ledON", msg.getMessageContent());
		} else {

			logger.info("light status is sending to /" + userName[1] + "/user");

			this.template.convertAndSendToUser(userName[1], "/ledOFF", msg.getMessageContent());
		}
	}

	@Override
	public void deliveryComplete(IMqttDeliveryToken token) {
		// TODO Auto-generated method stub

	}

	public Float getData() {
		if (dataToAWS == null)
			dataToAWS = 23.1f;

		return dataToAWS;
	}

}
