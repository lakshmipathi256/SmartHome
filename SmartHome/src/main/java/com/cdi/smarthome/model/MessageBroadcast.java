
package com.cdi.smarthome.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * This POJO is for broadcasting (or publishing) the received message (
 * {@link SimpleMessage}) to all clients who are subscribed to the
 * <code>/topic/simplemessages</code> message queue.
 * 
 * 
 */
@Entity
@Table(name = "log")

public class MessageBroadcast {
	@Id
	@Column(name = "log_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int logId;
	@Column(name = "message")
	private String messageContent;
	@Column(name = "topic")
	private String topic;
	@Column(name = "date")
	private String date;
	@Column(name = "direction")
	private String direction;

	public MessageBroadcast() {

	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public MessageBroadcast(String messageContent) {
		this.messageContent = messageContent;
	}

	public int getLogId() {
		return logId;
	}

	public void setLogId(int logId) {
		this.logId = logId;
	}

	public String getMessageContent() {
		return messageContent;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

}
