package com.cdi.smarthome.dao.impl;

import java.security.Principal;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.springframework.stereotype.Component;

import com.cdi.smarthome.dao.AbstractDao;
import com.cdi.smarthome.dao.MessageDAO;
import com.cdi.smarthome.model.MessageBroadcast;
@Component
public class MessageDaoImpl extends AbstractDao<Integer, MessageBroadcast> implements MessageDAO{

	final Logger logger = Logger.getLogger(MessageDaoImpl.class);
	
	@Override
	public void saveGatewayData(MessageBroadcast message) {
		
		logger.info(message+" is saved in database");
		persist(message);
	}
	

	@SuppressWarnings("unchecked")
	public List<MessageBroadcast> tempMessageList(Principal principal) {
		Query query=createEntityQuery("select mg.message from log mg where mg.topic=:code ORDER BY mg.log_id DESC LIMIT 10");
	
		logger.info("fetchin previous temperature data");
		
		query.setParameter("code", "/CDI000004/Temp");
		return  query.list();
	}

	@SuppressWarnings("unchecked")
	public List<MessageBroadcast> tempRfidList(Principal principal) {
		
		Query query=createEntityQuery("select mg.message from log mg where mg.topic=:code ORDER BY mg.log_id DESC LIMIT 5");
		query.setParameter("code", "/1/Rfid");
		return  query.list();
	}


	

	
}
