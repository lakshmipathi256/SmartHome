

package com.cdi.smarthome.model;

/**
 * This POJO represents a simple Message. The websocket service running on the
 * servlet container will accept from the client browser and send a message back
 * by using this POJO.
 * 
 * The message will be in a JSON format and sent over as a STOMP message. This
 * POJO simply represents the JSON object which will be like this -
 * 
 
 * 
 * </pre>
 * 
 * Furthermore, when the server receives this {@link SimpleMessage} object, the
 * contents i.e. the <code>message</code> will be extracted. Then the web socket
 * service create a new message and publish it on a separate queue to which the
 * client (end user) is subscribed to. <br/>
 * Note that Spring uses the <a
 * href="http://wiki.fasterxml.com/JacksonHome">Jackson JSON</a> library for
 * marshalling and unmarshalling the instances of {@link SimpleMessage
 * } to and
 * from JSON

 * 
 */
public class SimpleMessage {

	private String message;

	public String getMessage() {
		return this.message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
}
