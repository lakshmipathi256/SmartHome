package com.cdi.smarthome.service;

import java.security.Principal;
import java.util.List;

import com.cdi.smarthome.model.MessageBroadcast;
import com.cdi.smarthome.model.UserDetails;
import com.cdi.smarthome.model.UserType;

public interface UserService {
	

	void saveGatewayData(MessageBroadcast messagemessage);

	List<MessageBroadcast> tempMessageList(Principal principal);

	List<MessageBroadcast> tempRfidList(Principal principal);

	void userRegistration(UserDetails userForm);

	List<UserType> getRole();

	UserType findroleById(Integer id);

	UserDetails editProfile(Principal principal);

	void saveEditProfile(UserDetails userForm, Principal principal);

	List<UserDetails> findAllUsers();

	UserDetails editProfile(String id);

	void deleteUserById(String id);

}
