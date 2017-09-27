package com.cdi.smarthome.config;

import org.apache.log4j.Logger;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;

public class MQTTConnection {
	private static MqttClient client = null;
	static Logger logger = Logger.getLogger(MQTTConnection.class);

	private MQTTConnection() {
	}

	public static MqttClient getInstance() {
		if (client == null) {
			try {
				client = new MqttClient("tcp://172.16.73.4:1883", "pahomqttpublish1");
				client.connect();
				System.err.println("its in mqtt connection");
				logger.info("MQTT borker is connected");

			} catch (MqttException e) {
				logger.info("MQTT borker is not connected");
				
				e.printStackTrace();

			}
		}
		return client;

	}
}
