package com.cdi.smarthome.dao;

import java.security.Principal;
import java.util.List;

import com.cdi.smarthome.model.MessageBroadcast;

public interface MessageDAO {

	void saveGatewayData(MessageBroadcast message);
	List<MessageBroadcast> tempMessageList(Principal principal);
	List<MessageBroadcast> tempRfidList(Principal principal);


}
