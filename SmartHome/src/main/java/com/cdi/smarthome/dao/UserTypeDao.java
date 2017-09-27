package com.cdi.smarthome.dao;

import java.util.List;
import java.util.Set;

import com.cdi.smarthome.model.UserType;

public interface UserTypeDao {

	List<UserType> getRole();

	UserType findroleById(Integer id);
	
	UserType findRoleById(Set<UserType> userType);

}
