package com.cdi.smarthome.dao;

import java.security.Principal;
import java.util.List;

import com.cdi.smarthome.model.UserDetails;

public interface UserDao {

	UserDetails findUserById(String userId);

	void userRegistration(UserDetails userForm);

	void saveEditProfile(com.cdi.smarthome.model.UserDetails userForm, Principal principal);

	List<com.cdi.smarthome.model.UserDetails> editProfile(Principal principal);

	List<com.cdi.smarthome.model.UserDetails> findAllUsers();

	com.cdi.smarthome.model.UserDetails editProfile(String id);

	void deleteUserById(String id);

}
