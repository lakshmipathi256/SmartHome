package com.cdi.smarthome.dao.impl;

import java.security.Principal;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.cdi.smarthome.controller.DashboardController;
import com.cdi.smarthome.dao.AbstractDao;
import com.cdi.smarthome.dao.UserDao;
import com.cdi.smarthome.model.UserDetails;

@Component
public class UserDaoImpl extends AbstractDao<Integer, UserDetails> implements UserDao {

	final Logger logger = Logger.getLogger(DashboardController.class);

	@SuppressWarnings("unchecked")
	public UserDetails findUserById(String userId) {
		UserDetails userDetails = null;
		/*
		 * Criteria criteria =
		 * sessionFactory.getCurrentSession().createCriteria(UserDetails.class);
		 */
		Criteria criteria = createEntityCriteria();
		criteria.add(Restrictions.eq("id", userId));

		logger.info(userId + " is logged in");
		List<UserDetails> entityList = criteria.list();
		if (!entityList.isEmpty()) {
			userDetails = entityList.get(0);
		}
		return userDetails;
	}

	@Override
	public void userRegistration(UserDetails userForm) {
		persist(userForm);
	}

	@Override
	public void saveEditProfile(UserDetails userForm, Principal principal) {
		Query query=createEntityQuery("UPDATE UserDetails set name ='"+userForm.getName()+"',dob='"+userForm.getDob()+"',phone='"+userForm.getPhone()+"', "
				+ "email='"+userForm.getEmail()+"',address='"+userForm.getAddress()+"' , image = '"+userForm.getImage()+"' "  + 
	             "WHERE id = :user_id");
		          
		query.setParameter("user_id",principal.getName());
		query.executeUpdate();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UserDetails> editProfile(Principal principal) {
		
		Criteria criteria=createEntityCriteria();
		criteria.add(Restrictions.eq("id",principal.getName()));
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UserDetails> findAllUsers() {
		Criteria criteria = createEntityCriteria().addOrder(Order.asc("name"));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);//To avoid duplicates.
		List<UserDetails> userDetails = (List<UserDetails>) criteria.list();
		return userDetails;
	}

	@Override
	public UserDetails editProfile(String id) {
		Criteria criteria=createEntityCriteria();
		criteria.add(Restrictions.eq("id",id));
		UserDetails user = (UserDetails)criteria.uniqueResult();
		if(user!=null){
			Hibernate.initialize(user.getUserType());
		}
		return user;
	}

	@Override
	public void deleteUserById(String id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		UserDetails user = (UserDetails)crit.uniqueResult();
		delete(user);
		
	}

}
