package com.cdi.smarthome.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import com.cdi.smarthome.roleconverter.RoleTouserConverter;

/*
* @author CDI server Team(Basappa and Lakshmi)
* 
*  This is an web configuration class we are extending the WebMvcConfigurerAdapter class property and setting the JS, CSS file location
*  Setting the prefix and suffix for the jsp pages based on InternalResourceViewResolver 
**/
@Configuration
public class WebConfig extends WebMvcConfigurerAdapter {

	@Autowired
	private RoleTouserConverter roleToUSerConverter;
	@Override
	public void addResourceHandlers(final ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/*.js/**").addResourceLocations("/ui/static/");
		registry.addResourceHandler("/*.css/**").addResourceLocations("/ui/static/");
	}

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("login");
		registry.addViewController("/login").setViewName("login");
	}

	@Bean
	public InternalResourceViewResolver setupViewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/ui/jsp/");
		resolver.setSuffix(".jsp");
		resolver.setViewClass(JstlView.class);
		return resolver;
	}
	  @Override
	    public void addFormatters(FormatterRegistry registry) {
	        registry.addConverter(roleToUSerConverter);
	    }
		
}
