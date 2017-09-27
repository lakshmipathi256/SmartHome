package com.cdi.smarthome.config;

import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.hibernate4.LocalSessionFactoryBean;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
/*
*	  @author CDI server Team(Basappa and Lakshmi)
*
*     This is bean configuration class here we are configuring database connection, session hibernateProperties
*
*/

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.cdi.smarthome")
public class BeanConfig {

    @Bean
    public LocalSessionFactoryBean sessionFactory() {
        LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
        sessionFactory.setDataSource(dataSource());
        sessionFactory.setPackagesToScan(new String[]{"com.cdi.smarthome.model"});
        sessionFactory.setHibernateProperties(hibernateProperties());
        return sessionFactory;
    }

    @Bean
    public DataSource dataSource() {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/iot");
        dataSource.setUsername("root");
        dataSource.setPassword("root");
        return dataSource;
    }

    @SuppressWarnings("serial")
	Properties hibernateProperties() {
        return new Properties() {
            {
                setProperty("hibernate.hbm2ddl.auto", "update");
                setProperty("hibernate.dialect", "org.hibernate.dialect.MySQL5InnoDBDialect");
                setProperty("hibernate.show_sql", "true");
            }
        };
    }

}
