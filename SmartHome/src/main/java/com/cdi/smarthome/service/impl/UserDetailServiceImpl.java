package com.cdi.smarthome.service.impl;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.cdi.smarthome.dao.MessageDAO;
import com.cdi.smarthome.dao.UserDao;
import com.cdi.smarthome.dao.UserTypeDao;
import com.cdi.smarthome.model.MessageBroadcast;
import com.cdi.smarthome.model.UserType;
import com.cdi.smarthome.model.Util;
import com.cdi.smarthome.service.UserService;

@Component(value = "userDetailService")

@Transactional
public class UserDetailServiceImpl implements UserDetailsService, UserService {

	@Autowired
	private UserDao userDao;
	@Autowired
	private MessageDAO messageDAO;
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private UserTypeDao userTypeDao;

	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		com.cdi.smarthome.model.UserDetails user = null;
		/*
		 * ExecutorService executorService =
		 * Executors.newSingleThreadExecutor(); executorService.submit(() -> {
		 */
		user = userDao.findUserById(userId);
		/* }); */
		if (user == null) {
			throw new UsernameNotFoundException("Invalid username or password.");
		}
		return new org.springframework.security.core.userdetails.User(user.getId(), user.getPassword(),
				getAuthority(user));
	}

	private List<GrantedAuthority> getAuthority(com.cdi.smarthome.model.UserDetails user) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

		for (UserType userType : user.getUserType()) {
			
			authorities.add(new SimpleGrantedAuthority("ROLE_" + userType.getUserType()));
			System.err.println("ROLE_" + userType.getUserType());
		}
		return authorities;

	}

	@Override
	public void saveGatewayData(MessageBroadcast message) {
		String Date = Util.getSimpleDate();
		message.setDate(Date);
		messageDAO.saveGatewayData(message);

	}

	@Override
	public List<MessageBroadcast> tempMessageList(Principal principal) {
		// TODO Auto-generated method stub
		return messageDAO.tempMessageList(principal);
	}

	@Override
	public List<MessageBroadcast> tempRfidList(Principal principal) {
		// TODO Auto-generated method stub
		return messageDAO.tempRfidList(principal);
	}

	@Override
	public void userRegistration(com.cdi.smarthome.model.UserDetails userForm) {
		userForm.setPassword(passwordEncoder.encode(userForm.getPassword()));

		userDao.userRegistration(userForm);

	}

	@Override
	public List<UserType> getRole() {
		// TODO Auto-generated method stub
		return userTypeDao.getRole();
	}

	@Override
	public UserType findroleById(Integer id) {
		// TODO Auto-generated method stub
		return userTypeDao.findroleById(id);
	}

	@Override
	public com.cdi.smarthome.model.UserDetails editProfile(Principal principal) {
		// TODO Auto-generated method stub

		List<com.cdi.smarthome.model.UserDetails> details1 = userDao.editProfile(principal);
		com.cdi.smarthome.model.UserDetails details = (com.cdi.smarthome.model.UserDetails) details1.get(0);

		return (com.cdi.smarthome.model.UserDetails) details;
	}

	public void saveEditProfile(com.cdi.smarthome.model.UserDetails userForm, Principal principal) {
		// TODO Auto-generated method stub
		userDao.saveEditProfile(userForm, principal);
	}

	@Override
	public List<com.cdi.smarthome.model.UserDetails> findAllUsers() {
		// TODO Auto-generated method stub
		return userDao.findAllUsers();
	}

	@Override
	public com.cdi.smarthome.model.UserDetails editProfile(String id) {
		// TODO Auto-generated method stub
		return userDao.editProfile(id);
	}

	@Override
	public void deleteUserById(String id) {
		userDao.deleteUserById(id);
		
	}

}
