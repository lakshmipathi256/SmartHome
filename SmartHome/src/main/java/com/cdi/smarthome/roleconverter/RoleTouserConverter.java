package com.cdi.smarthome.roleconverter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import com.cdi.smarthome.model.UserType;
import com.cdi.smarthome.service.UserService;

@Component
public class RoleTouserConverter implements Converter<Object,UserType> {

	@Autowired
	private UserService userService;
	@Override
	public UserType convert(Object source) {
		Integer id = Integer.parseInt((String)source);
		UserType usertype=userService.findroleById(id);
		return usertype;
	}

}
