/*
 * Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

package com.cdi.smarthome.AWSconfig;

import org.apache.log4j.Logger;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;

import com.amazonaws.services.iot.client.AWSIotMessage;
import com.amazonaws.services.iot.client.AWSIotQos;
import com.amazonaws.services.iot.client.AWSIotTopic;
import com.cdi.smarthome.config.MQTTConnection;

/**
 * This class extends {@link AWSIotTopic} to receive messages from a subscribed
 * topic.
 */
public class TestTopicListener extends AWSIotTopic {

	final Logger logger = Logger.getLogger(TestTopicListener.class);
	
    public TestTopicListener(String topic, AWSIotQos qos) {
        super(topic, qos);
    }

    @Override
    public void onMessage(AWSIotMessage message) {
    	logger.info( ": <<< " + message.getStringPayload());
      
        String mqttTopic=message.getTopic();
        MqttClient client=MQTTConnection.getInstance();
        String msg=message.getStringPayload();
       
        msg = msg.replace("\"","");
        message.setPayload(msg.getBytes());
     
        MqttMessage data = new MqttMessage( message.getPayload());
      
        try {
			client.publish(mqttTopic, data);
		} catch (MqttException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
    } 

}
