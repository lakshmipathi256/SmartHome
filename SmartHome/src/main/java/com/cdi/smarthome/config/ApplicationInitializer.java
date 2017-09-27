package com.cdi.smarthome.config;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;
/*
*	@author CDI server Team(Basappa and Lakshmi)
*
*	This is a front controller first http request enters in this class 
*	Here we are implementing  WebApplicationInitializer get the property of dispatcher servlet 
*/

public class ApplicationInitializer implements WebApplicationInitializer {

    public void onStartup(ServletContext container) throws ServletException {

        AnnotationConfigWebApplicationContext ctx = new AnnotationConfigWebApplicationContext();
        ctx.setServletContext(container);
        ServletRegistration.Dynamic servlet = container.addServlet("dispatcher", new DispatcherServlet(ctx));
        servlet.setLoadOnStartup(1);
        servlet.addMapping("/");  /* here every / request will comes to this method and route to appropriate controller */
    }
}