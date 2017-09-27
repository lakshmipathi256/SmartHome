package com.cdi.smarthome.config;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.hibernate.HibernateException;
import org.hibernate.engine.spi.SessionImplementor;
import org.hibernate.id.IdentifierGenerator;

public class CustomGenerator implements IdentifierGenerator {
	
	private String defaultPrefix = "CDI";
	private int defaultNumber = 1;

	@Override
	public Serializable generate(SessionImplementor session, Object object) throws HibernateException {
		
		String empId = "";
        String digits = "";

		Connection con = session.connection();

		try {

			java.sql.PreparedStatement pst = con.prepareStatement("select id from userdetails order by id desc limit 1");

			ResultSet rs = pst.executeQuery();

			if (rs != null && rs.next()) {

				empId = rs.getString("id");

				System.out.println(empId);

				String prefix = empId.substring(0, 3);

				String str[] = empId.split(prefix);

				digits = String.format("%06d", Integer.parseInt(str[1]) + 1);

				empId = prefix.concat(digits);

			} else {

				digits = String.format("%06d", defaultNumber);

				empId = defaultPrefix.concat(digits);

			}

		} catch (SQLException e) {

			e.printStackTrace();

		}

		return empId;
	}

}
