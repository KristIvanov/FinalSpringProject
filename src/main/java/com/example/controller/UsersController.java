package com.example.controller;



import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

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
	private static String fileName = "index";
	private static String errorMsg = " ";
       
	
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String sayHi(Model viewModel,HttpServletRequest request,HttpSession session,HttpServletResponse response) {
		
			String username = request.getParameter("username");
			System.out.println(username);
			String password = request.getParameter("password").trim();

			if(UsersManager.getInstance().validateLogin(username, UsersManager.getInstance().hashPassword(password))){
				session.setAttribute("username", username);
				session.setAttribute("logged", true);
				User u = UsersManager.getInstance().getRegisteredUsers().get(username);
				session.setAttribute("firstname", u.getFirst_name());
				session.setAttribute("lastname", u.getLast_name());
				session.setAttribute("email", u.getEmail());
				response.setHeader("Pragma", "No-cache");
				response.setDateHeader("Expires", 0);
				response.setHeader("Cache-control", "no-cache");
				fileName = "settings";
				if(session.getAttribute("url") != null) {
					fileName = (String) session.getAttribute("url");
				}
			}
			else{
				fileName = "login";
				errorMsg = "We did not recognise your username and password";
			}
			viewModel.addAttribute("errorMsg", errorMsg);

			return fileName;
	}

	
	@RequestMapping(value="/logout", method=RequestMethod.POST)
	public String sayBye(Model viewModel, HttpSession session) {
		session.setAttribute("logged", false);
		session.invalidate();
		return fileName;
		
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String register(Model viewModel,HttpSession session,HttpServletRequest req) {
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
		
		try {
			this.validateData(username, password, firstname, lastname, email);
			UsersManager.getInstance().register(username, password, firstname, lastname, email);
		} catch (InvalidInputException e) {
			fileName= "register";
		}
		viewModel.addAttribute("errorMsg", errorMsg);
		return "fileName";
	}
	
	@RequestMapping(value="/updateInfo", method=RequestMethod.GET)
	public String prepareForUpdate() {
		return "updateInfo";
	}
	@RequestMapping(value="/index", method=RequestMethod.GET)
	public String prepareForIndex() {
		return "index";
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
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String prepareForLogout() {
		return "logout";
	}
	@RequestMapping(value="/profile", method=RequestMethod.GET)
	public String profile() {
		return "profile";
	}
	
	@RequestMapping(value="/updateInfo", method=RequestMethod.POST)
	public String update(Model viewModel, HttpSession session,HttpServletRequest req) {
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
				System.out.println(newLastname + "newlastname");
				System.out.println(u.getLast_name() + " u.getLastname");
				if (newLastname != u.getLast_name()){
					if (newLastname==null || newLastname.isEmpty()){
						errorMsg = "Enter last name please!";
					}
					else{
						u.setLast_name(newLastname);
						System.out.println(u.getLast_name());
					}
				}
				if (newFirstname != u.getFirst_name()){
					System.out.println(newFirstname + " <- newFirsname if");
					if (newFirstname==null || newFirstname.isEmpty()){
						errorMsg = "Enter first name please!";
					}
					else{
						u.setFirst_name(newFirstname);
						System.out.println(u.getFirst_name());
					}
				}
				if ((String )session.getAttribute("username")==newUsername){
					//check if username is valid
					if(newUsername == null || newUsername.isEmpty() || UsersManager.getInstance().getRegisteredUsers().containsKey(newUsername)){
						errorMsg = "Username already taken";
					}
					else {
						u.setUsername(newUsername);
						System.out.println(u.getUsername());
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
		return "filename";
			
		} 
	
	//view user's profile
	@RequestMapping(value="/user/{username}",method = RequestMethod.GET)
	public String viewProfile(Model model, @PathVariable("username") String username) {
		User u = UsersManager.getInstance().getRegisteredUsers().get(username);
		model.addAttribute("usersprofile",u);
		return "profile";
	}
	
	@RequestMapping(value="/changePass",method = RequestMethod.POST)
	public String changePass(Model model, HttpServletRequest req, HttpSession session) {
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
				}
			}
			else{
				errorMsg = "Password does not match our records, your changes were not saved!";
			}
			
		}
		else{
			fileName="login";
		}
		return fileName;
	}
	
	@RequestMapping(value="/forgotPassword",method = RequestMethod.GET)
	public String forgotPass(Model model,HttpServletRequest request ) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String htmlFile="";
		if(!UsersManager.getInstance().getRegisteredUsers().containsKey(username)) {
			htmlFile="forgotPassword.html";
		} 
		else{
			htmlFile="passwordSent.html";
			String password = UsersManager.getInstance().getRegisteredUsers().get(username).getPassword();
			new MailSender(email, "Забравена парола за Travelbook", "Вашата парола е " + password + " . Заповядайте отново!");
		}
		return "redirect:/" +htmlFile;
	}
	
	@RequestMapping(value="/newsFeed",method = RequestMethod.GET)
	public String newsFeed(Model model, HttpSession ses  ) {
		ArrayList<Post> posts =null;
		if(ses.getAttribute("logged")!= null){
			posts = new ArrayList<>();
			String username = (String) ses.getAttribute("username");
			User u = UsersManager.getInstance().getRegisteredUsers().get(username);
			for (Post post : PostManager.getInstance().getPosts().values()) {
				if (u.getFollowing().contains(post.getAuthor())){
					posts.add(post);
				}
			}
				//each post in different form ?
		}
		else{
			fileName="login";
		}
	
		model.addAttribute("posts",posts);
		return fileName;
	}
	
	
	
	
	private  void validateData(String username, String password, String firstName, String lastName, String email) throws InvalidInputException{
		if(username == null || username.isEmpty() || UsersManager.getInstance().getRegisteredUsers().containsKey(username)) {
			errorMsg = "Invalid username!";
			throw new InvalidInputException("Invalid username!");
		}
		if(!checkString(firstName)) {
			errorMsg = "Invalid first name!";
			throw new InvalidInputException("Invalid first name!");
		}
		if(!checkString(lastName)) {
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
	
	
}
