package com.cdi.smarthome.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cdi.smarthome.config.Email;
import com.cdi.smarthome.config.MQTTConnection;
import com.cdi.smarthome.model.MessageBroadcast;
import com.cdi.smarthome.model.UserDetails;
import com.cdi.smarthome.model.UserType;
import com.cdi.smarthome.service.UserService;


/*
 *  @author CDI server Team(Basappa and Lakshmi)
 *  After successful login spring security will route this controller.
 *  returning to home.jsp page
*/
@Controller
public class DashboardController {
	final Logger logger = Logger.getLogger(DashboardController.class);
	MqttClient client;
	@Autowired
	private UserService userService;
	@Autowired
	private SubscriberController subscriberController;

	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public ModelAndView dashboard(Principal principal) {
		client = MQTTConnection.getInstance();
		logger.info("login user is " + principal.getName());
		subscriberController.LEDonSubscribe(principal);

		subscriberController.LEDoffSubscribe(principal);
		subscriberController.RFIDSubscribe(principal);
		subscriberController.TempSubscribe(principal);

		logger.info(principal.getName() + "is subscribed to devices");

		ModelAndView model = new ModelAndView();
		List<MessageBroadcast> listmessages = userService.tempMessageList(principal);
		model.addObject("listmessages", listmessages);

		List<MessageBroadcast> listRfid = userService.tempRfidList(principal);
		model.addObject("listRfid", listRfid);

		model.addObject("userId", principal.getName());
		
		List<UserDetails> userlist = userService.findAllUsers();
		model.addObject("userlist", userlist);
		model.setViewName("home");
		return model;
	}

	@RequestMapping(value = "/registration", method = RequestMethod.GET)
	public String registration(Model model) {
		
		List<UserType> roleList = new ArrayList<UserType>();
		roleList = userService.getRole();
		model.addAttribute("roleList", roleList);

		model.addAttribute("userForm", new UserDetails());
		return "registration";
	}

	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public ModelAndView registration(@ModelAttribute("userForm") UserDetails userForm) {
		
		ModelAndView model = new ModelAndView();
		userService.userRegistration(userForm);
		Email.sendFromGMail(userForm);
		
		model.setViewName("success");

		return model;
	}
	
	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public ModelAndView profile(Principal principal)
	{
		ModelAndView model = new ModelAndView();
		model.addObject("userForm", new UserDetails());
		UserDetails listprofile = userService.editProfile(principal);
		model.addObject("userId", principal.getName());
		model.addObject("listprofile", listprofile);
		model.setViewName("profile");
		return model;
	}
	
	
	@RequestMapping(value = "/success", method = RequestMethod.POST)
	public String profileSave(@ModelAttribute("userForm") UserDetails userForm,Principal principal ) throws IOException {
		
	
		// BufferedImage image = ImageIO.read(new URL("http://upload.wikimedia.org/wikipedia/en/2/24/Lenna.png"));
		
			userService.saveEditProfile(userForm,principal);
			
		return "redirect:dashboard";
	}
	@RequestMapping(value = { "/edit-user-{id}" }, method = RequestMethod.GET)
	public ModelAndView editUser(@PathVariable String id,Principal principal) {
		ModelAndView model = new ModelAndView();
		model.addObject("userForm", new UserDetails());
		model.addObject("userId", principal.getName());
		UserDetails listprofile = userService.editProfile(id);
		model.addObject("listprofile", listprofile);
		model.setViewName("profile");
		return model;
	}
	@RequestMapping(value = { "/delete-user-{id}" }, method = RequestMethod.GET)
	public String deleteUser(@PathVariable String id) {
		userService.deleteUserById(id);
		return "redirect:dashboard";
	}
}
