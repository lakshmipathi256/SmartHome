package com.cdi.smarthome.dao.impl;

import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.springframework.stereotype.Repository;

import com.cdi.smarthome.dao.AbstractDao;
import com.cdi.smarthome.dao.UserTypeDao;
import com.cdi.smarthome.model.UserType;
@Repository
public class UserTypeDaoimpl extends AbstractDao<Integer, UserType>implements UserTypeDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<UserType> getRole() {
		Criteria criteria = createEntityCriteria();
		return criteria.list();
	}

	@Override
	public UserType findroleById(Integer id) {
		return getByKey(id);
	}

	@Override
	public UserType findRoleById(Set<UserType> usertype) {
		// TODO Auto-generated method stub
		return getByKey(2);
	}

}
