package com.example.controller;



import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import java.util.Random;
import java.util.TreeSet;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.model.InvalidInputException;
import com.example.model.MailSender;
import com.example.model.Post;
import com.example.model.User;
import com.example.model.managers.PostManager;
import com.example.model.managers.UsersManager;


@Controller
public class UsersController {
	private static String fileName = "indexx";
	private static String errorMsg = " ";
       
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String sayHi(Model viewModel,HttpServletRequest request,HttpSession session,HttpServletResponse response) {
		
			String username = request.getParameter("username");
			String password = request.getParameter("password").trim();

			if(UsersManager.getInstance().validateLogin(username, UsersManager.getInstance().hashPassword(password))){
				session.setAttribute("username", username);
				session.setAttribute("logged", true);
				User u = UsersManager.getInstance().getRegisteredUsers().get(username);
				session.setAttribute("firstname", u.getFirst_name());
				session.setAttribute("lastname", u.getLast_name());
				session.setAttribute("email", u.getEmail());
				fileName = "updateInfo";
				if(session.getAttribute("url") != null) {
					fileName = (String) session.getAttribute("url");
					if(session.getAttribute("postId") != null) {
						Long id = (Long) session.getAttribute("postId");
						Post p = PostManager.getInstance().getPosts().get(id);
						viewModel.addAttribute("post",p);
						fileName= "post";
					}
				}
			}
			else{
				fileName = "login";
				errorMsg = "We did not recognise your username and password";
			}
			viewModel.addAttribute("errorMsg", errorMsg);
			errorMsg=null;
			removeCacheFromResponse(response);
			return fileName;
	}

	
	@RequestMapping(value="/logout", method=RequestMethod.POST)
	public String sayBye(Model viewModel, HttpSession session, HttpServletResponse response) {
		session.setAttribute("username", null);
		session.invalidate();
		fileName = "indexx";
		removeCacheFromResponse(response);
		return fileName;
		
	}
	
	@RequestMapping(value="/follow", method=RequestMethod.POST)
	public String follow(Model viewModel, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		String username = (String) session.getAttribute("username");
		String usersProfileName = (String)session.getAttribute("usersprofile");
		User user = UsersManager.getInstance().getRegisteredUsers().get(username);
		User userProfile = UsersManager.getInstance().getRegisteredUsers().get(usersProfileName);
		System.out.println("follow method");
		UsersManager.getInstance().follow(user, userProfile);
		
		return "user/" + usersProfileName;
	}
	
	@RequestMapping(value="/unfollow", method=RequestMethod.POST)
	public String unfollow(Model viewModel, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		String username = (String) session.getAttribute("username");
		String usersProfileName = (String)session.getAttribute("usersprofile");
		User user = UsersManager.getInstance().getRegisteredUsers().get(username);
		User userProfile = UsersManager.getInstance().getRegisteredUsers().get(usersProfileName);
		UsersManager.getInstance().unFollow(user, userProfile);
		
		return "user/" + usersProfileName;
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String register(Model model,HttpSession session,HttpServletRequest req, HttpServletResponse response) {
		String username = req.getParameter("username").trim();
		String password = req.getParameter("password").trim();
		String firstname = req.getParameter("firstname").trim();
		String lastname = req.getParameter("lastname").trim();
		String email = req.getParameter("email").trim();
		//saving old inputs in session to have filled inputs if something was invalid
		session.setAttribute("username", username);
		session.setAttribute("password", password);
		session.setAttribute("firstname", firstname);
		session.setAttribute("lastname", lastname);
		session.setAttribute("email", email);
		fileName="login";
		try {
			this.validateData(username, password, firstname, lastname, email);
			UsersManager.getInstance().register(username, password, firstname, lastname, email);
		} catch (InvalidInputException e) {
			fileName= "register";
		}
		model.addAttribute("errorMsg", errorMsg);
		errorMsg=null;
		removeCacheFromResponse(response);
		return fileName;
	}
	@RequestMapping(value="/deleteAccount", method=RequestMethod.POST)
	public String deleteAccount(Model model,HttpSession session,HttpServletRequest req, HttpServletResponse response) {
		String username = (String) session.getAttribute("username");
		String password = req.getParameter("password").trim();
		User u = UsersManager.getInstance().getRegisteredUsers().get((String )session.getAttribute("username"));
		if (UsersManager.getInstance().hashPassword(password).equals(u.getPassword())){
			UsersManager.getInstance().delete(u);
		}
		removeCacheFromResponse(response);
		model.addAttribute("message", "Account successfully deleted!");
		return "indexx";
	}
	@RequestMapping(value="/deleteAccount", method=RequestMethod.GET)
	public String deleteAcc() {
		return "deleteAccount";
	}
	@RequestMapping(value="/updateInfo", method=RequestMethod.GET)
	public String prepareForUpdate() {
		return "updateInfo";
	}
	@RequestMapping(value="/index", method=RequestMethod.GET)
	public String prepareForIndex() {
		return "indexx";
	}
	@RequestMapping(value="/indexx", method=RequestMethod.GET)
	public String prepareForIndexx(HttpServletResponse response) {
		removeCacheFromResponse(response);
		return "indexx";
	}
	@RequestMapping(value="/settings", method=RequestMethod.GET)
	public String settings() {
		return "settings";
	}
	@RequestMapping(value="/addComment", method=RequestMethod.GET)
	public String comment() {
		return "addComment";
	}
	@RequestMapping(value="/addPost", method=RequestMethod.GET)
	public String post() {
		return "addPost";
	}
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public String register() {
		return "register";
	}
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String prepareForLogIn() {
		return "login";
	}
	@RequestMapping(value="/testPostMap", method=RequestMethod.GET)
	public String wall() {
		return "testPostMap";
	}
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String prepareForLogout() {
		return "logout";
	}
	@RequestMapping(value="/forgotPassword", method=RequestMethod.GET)
	public String forgotPass() {
		return "forgotPassword";
	}
	@RequestMapping(value="/errorPage", method=RequestMethod.GET)
	public String errorPage() {
		return "errorPage";
	}
	@RequestMapping(value="/comingSoon", method=RequestMethod.GET)
	public String comingSoon() {
		return "comingSoon";
	}
	@RequestMapping(value="/contactUs", method=RequestMethod.GET)
	public String contactUs() {
		return "contactUs";
	}
	
	@RequestMapping(value="/contactUs", method=RequestMethod.POST)
	public String contact(Model model, HttpServletRequest request, HttpServletResponse response) {
		String email = request.getParameter("email");
		String message = request.getParameter("message");
		UsersManager.getInstance().contactUs(email, message);
		errorMsg = "Message successfully sent!";
		model.addAttribute("errorMsg", errorMsg);
		errorMsg=null;
		removeCacheFromResponse(response);
		return "contactUs";
		
	}
	@RequestMapping(value="/profile", method=RequestMethod.GET)
	public String profile(Model model, HttpSession session, HttpServletResponse response) {
		if(session.getAttribute("logged") != null) {
			User u = UsersManager.getInstance().getRegisteredUsers().get(session.getAttribute("username"));
			model.addAttribute("usersprofile", u);
			System.out.println("Users posts -" + u.getPosts().size());
			fileName = "profile";
		}
		else {
			fileName = "login";
		}
		
		removeCacheFromResponse(response);
		return fileName;
	}
	
	@RequestMapping(value="/updateInfo", method=RequestMethod.POST)
	public String update(Model viewModel, HttpSession session,HttpServletRequest req, HttpServletResponse response) {
		if(session.getAttribute("logged")!= null){
			String newUsername = req.getParameter("newUsername").trim();
			String newFirstname = req.getParameter("newFirstname").trim();
			String newLastname = req.getParameter("newLastname").trim();
			String newEmail = req.getParameter("newEmail").trim();
			String confirmPass = req.getParameter("confirmPassword").trim();
			User u = UsersManager.getInstance().getRegisteredUsers().get((String )session.getAttribute("username"));
			if (UsersManager.getInstance().hashPassword(confirmPass).equals(u.getPassword())){
				if (newEmail != u.getEmail()){
					if (!UsersManager.getInstance().validateEmailAddress(newEmail)){
						errorMsg = "New email address not valid";
					}
					else {
						u.setEmail(newEmail);
					}
				}
				if (newLastname != u.getLast_name()){
					if (newLastname==null || newLastname.isEmpty()){
						errorMsg = "Enter last name please!";
					}
					else{
						u.setLast_name(newLastname);
					}
				}
				if (newFirstname != u.getFirst_name()){
					if (newFirstname==null || newFirstname.isEmpty()){
						errorMsg = "Enter first name please!";
					}
					else{
						u.setFirst_name(newFirstname);
					}
				}
				if ((String )session.getAttribute("username")==newUsername){
					//check if username is valid
					if(newUsername == null || newUsername.isEmpty() || UsersManager.getInstance().getRegisteredUsers().containsKey(newUsername)){
						errorMsg = "Username already taken";
					}
					else {
						u.setUsername(newUsername);
					}
				}
				if (errorMsg == " "){
					UsersManager.getInstance().updateUser(u);
					errorMsg = "Update successful";
				}
			}
			else {
				errorMsg = "Password does not match our records, your changes were not saved!";
			}
				
		}
		else{
			fileName="login";
		}
	
		session.invalidate();
		viewModel.addAttribute("errorMsg", errorMsg);
		errorMsg=null;
		removeCacheFromResponse(response);
		return fileName;
			
		} 
	
	//view user's profile
	@RequestMapping(value="user/{username:.+} ",method = RequestMethod.GET)
	public String viewProfile(Model model, @PathVariable("username") String username, HttpServletResponse response, HttpSession session) {
		if(UsersManager.getInstance().getRegisteredUsers().containsKey(username)) {
			User viewer = null;
			if (session.getAttribute("username")!=null){
				viewer = UsersManager.getInstance().getRegisteredUsers().get((String)session.getAttribute("username"));
				model.addAttribute("isFollowing", viewer.doesFollow(username));
			}
			User u = UsersManager.getInstance().getRegisteredUsers().get(username);
			model.addAttribute("usersprofile",u);
			session.setAttribute("usersprofile",u);
			removeCacheFromResponse(response);
			return "profile";
		}
		return "indexx";
	}
	
	@RequestMapping(value="/changePass",method = RequestMethod.POST)
	public String changePass(Model model, HttpServletRequest req, HttpSession session, HttpServletResponse response) {
		fileName= "updateInfo";
		if(session.getAttribute("logged")!= null){
			String oldPass = req.getParameter("oldPassword");
			String newPass = req.getParameter("newPassword");
			User u = UsersManager.getInstance().getRegisteredUsers().get((String )session.getAttribute("username"));
			if (UsersManager.getInstance().hashPassword(oldPass).equals(u.getPassword())){
				if (!UsersManager.getInstance().validatePassword(newPass)){
					errorMsg = "Password is not safe!";
				}
				else {
					UsersManager.getInstance().updatePass(newPass, u);
					errorMsg = "Password successfully changed!";
				}
			}
			else{
				errorMsg = "Password does not match our records, your changes were not saved!";
			}
			
		}
		else{
			fileName="login";
		}
		model.addAttribute("errorMsg", errorMsg);
		errorMsg=null;
		removeCacheFromResponse(response);
		return fileName;
	}
	
	@RequestMapping(value="/forgotPassword",method = RequestMethod.POST)
	public String forgotPass(Model model,HttpServletRequest request, HttpServletResponse response ) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String username = request.getParameter("username");
		User u = UsersManager.getInstance().getRegisteredUsers().get(username);
		String email = request.getParameter("email");
		if(!UsersManager.getInstance().getRegisteredUsers().containsKey(username)) {
			fileName = "forgotPassword";
			errorMsg= "No such user";
		} 
		else{
			fileName = "indexx";
			String password = generateNewPass();
			UsersManager.getInstance().updatePass(password, u);
			MailSender mailSender = new MailSender(email, "Нова парола за Travelbook", "Вашата нова парола е " + password + " . Заповядайте отново!");
			mailSender.start();
		}
		model.addAttribute("errorMsg", errorMsg);
		errorMsg=null;
		removeCacheFromResponse(response);
		return fileName;
	}
	
	@RequestMapping(value="/newsFeed",method = RequestMethod.GET)
	public String newsFeed(Model model, HttpSession ses, HttpServletResponse response) {
		TreeSet<Post> posts = new TreeSet<>((Post p1, Post p2)->p2.getDate().compareTo(p1.getDate()));
		if(ses.getAttribute("logged")!= null){
			fileName="newsFeed";
			String username = (String) ses.getAttribute("username");
			User u = UsersManager.getInstance().getRegisteredUsers().get(username);
			if(!PostManager.getInstance().getPosts().values().isEmpty()) {
				for (Post post : PostManager.getInstance().getPosts().values()) {
					if (u.getFollowing().contains(post.getAuthor().getUsername())){
						posts.add(post);
					}
				}
			}
		}
		else{
			fileName="login";
		}
		if(posts.size()==0) {
			posts=null;
		}
		removeCacheFromResponse(response);
		model.addAttribute("posts",posts);
		return fileName;
	}
	@RequestMapping(value="/users",method = RequestMethod.GET)
	public String users(Model model, HttpSession ses, HttpServletResponse response) {
		TreeSet<User> users = new TreeSet<>((User u1, User u2)-> u2.getUsername().compareTo(u1.getUsername()));
		for(User u : UsersManager.getInstance().getRegisteredUsers().values()) {
			users.add(u);
		}
		
		removeCacheFromResponse(response);
		model.addAttribute("users",users);
		return "users";
	}
	
	
	private  void validateData(String username, String password, String firstName, String lastName, String email) throws InvalidInputException{
		if(username == null || username.isEmpty() || username.length()<5 || UsersManager.getInstance().getRegisteredUsers().containsKey(username)) {
			errorMsg = "Invalid username!";
			throw new InvalidInputException("Invalid username!");
		}
		if(!checkString(firstName) || firstName.length()<3) {
			errorMsg = "Invalid first name!";
			throw new InvalidInputException("Invalid first name!");
		}
		if(!checkString(lastName) || lastName.length()<5) {
			errorMsg = "Invalid last name!";
			throw new InvalidInputException("Invalid last name!");
		}
		
		if (!UsersManager.getInstance().validateEmailAddress(email)) {
			errorMsg = "Invalid email!";
			throw new InvalidInputException("Invalid email!");
		}
		if(!UsersManager.getInstance().validatePassword(password)){
			
			errorMsg = "Invalid password!";
			throw new InvalidInputException("Invalid password!");
		}
	}
	
	private boolean checkString(String name) {
		if (name != null && !name.isEmpty()) {
			return true;
		}
		return false;
	}
	
	private  void removeCacheFromResponse(HttpServletResponse response) {
		response.setHeader("Pragma", "No-cache");
		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-control", "no-cache");
	}
	
	private String generateNewPass() {
		int digit1 = new Random().nextInt(10)+48;
		int upperCase = new Random().nextInt(26)+65;
		int lowerCase = new Random().nextInt(26)+97;
		int digit2 = new Random().nextInt(10)+48;
		int lowerCase2 = new Random().nextInt(26)+97;
		int upperCase2 = new Random().nextInt(26)+65;
		StringBuilder sb = new StringBuilder();
		sb.append((char)digit1);
		sb.append((char)digit2);
		sb.append((char)upperCase);
		sb.append((char)upperCase2);
		sb.append((char)lowerCase);
		sb.append((char)lowerCase2);
		System.out.println(digit1);
		System.out.println(digit2);
		System.out.println(upperCase);
		String newPass = sb.toString();
		return newPass;
	}
	
	
}
