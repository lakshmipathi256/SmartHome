package com.cdi.smarthome.controller;

import org.apache.log4j.Logger;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.stereotype.Controller;

import com.cdi.smarthome.config.MQTTConnection;

@Controller
public class PublisherController {
	final Logger logger = Logger.getLogger(PublisherController.class);
	MqttClient client;

	public void LEDOn(String messagereceive) {
		try {
			client = MQTTConnection.getInstance();
			System.out.println("Publishing message: " + messagereceive);
			MqttMessage message = new MqttMessage(messagereceive.getBytes());
			client.publish("light", message);
			
			logger.info("message published");
		} catch (MqttException me) {
			System.out.println("reason " + me.getReasonCode());
			System.out.println("msg " + me.getMessage());
			System.out.println("loc " + me.getLocalizedMessage());
			System.out.println("cause " + me.getCause());
			System.out.println("excep " + me);
			me.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void LEDOff(String messagereceive) {
		try {
			client = MQTTConnection.getInstance();
			System.out.println("Publishing message: " + messagereceive);
			MqttMessage message = new MqttMessage(messagereceive.getBytes());
			client.publish("light", message);

			logger.info("message published");

		} catch (MqttException me) {
			System.out.println("reason " + me.getReasonCode());
			System.out.println("msg " + me.getMessage());
			System.out.println("loc " + me.getLocalizedMessage());
			System.out.println("cause " + me.getCause());
			System.out.println("excep " + me);
			me.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
