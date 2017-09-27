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

import com.amazonaws.services.iot.client.AWSIotDevice;
import com.amazonaws.services.iot.client.AWSIotDeviceProperty;
import com.cdi.smarthome.controller.SubscriberController;

/**
 * This class encapsulates an actual device. It extends {@link AWSIotDevice} to
 * define properties that are to be kept in sync with the AWS IoT shadow.
 */
public class ConnectedWindow extends AWSIotDevice{
	final Logger logger = Logger.getLogger(ConnectedWindow.class);
    public ConnectedWindow(String thingName) {
        super(thingName);
    }
   
    @AWSIotDeviceProperty
    public float roomTemperature;


    public float getRoomTemperature() {
        // 1. Read the actual room temperature from the thermostat
      //  Random rand = new Random();
    	SubscriberController controller=new SubscriberController();
        float reportedTemperature = controller.getData();;
        // 2. (optionally) update the local copy
        this.roomTemperature = reportedTemperature; 
        // 3. return the current room temperature
        logger.info( " >>> reported room temperature: " + reportedTemperature);
        try {
			Thread.sleep(1000000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return this.roomTemperature;
    }
}
