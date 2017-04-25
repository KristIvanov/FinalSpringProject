package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.model.Post;
import com.example.model.User;
import com.example.model.managers.PostManager;
import com.example.model.managers.UsersManager;


@Controller
@MultipartConfig
public class UploadImageController {

	private static final String FILE_LOCATION = "C:\\travelBook\\usersProfilePics\\";
	private static String errorMsg = " ";

	

	
	@RequestMapping(value="/image", method=RequestMethod.GET)
	@ResponseBody
	public void viewPicture(HttpServletResponse resp, Model model,HttpSession session) throws IOException {
		String username = (String) session.getAttribute("username");
		User u = UsersManager.getInstance().getRegisteredUsers().get(username);
		File file;
		if(u.getPhotoURL()!=null) {
			 file = new File(u.getPhotoURL());
		}
		else {

			file = new File("C:\\travelBook\\usersProfilePics\\No_person.jpg");
		}
		Files.copy(file.toPath(), resp.getOutputStream());
	}
	
	@RequestMapping(value="/image/{username:.+}", method=RequestMethod.GET)
	@ResponseBody
	public void viewUsersPicture( @PathVariable("username") String username,HttpServletResponse resp, Model model,HttpSession session) throws IOException {
		User u = UsersManager.getInstance().getRegisteredUsers().get(username);
		File file;
		if(u.getPhotoURL()!=null) {
			 file = new File(u.getPhotoURL());
		}
		else {

			file = new File("C:\\travelBook\\usersProfilePics\\No_person.jpg");
		}
		Files.copy(file.toPath(), resp.getOutputStream());
	}
	@RequestMapping(value="/picture/{post_id:.+}", method=RequestMethod.GET)
	@ResponseBody
	public void viewPostPicture( @PathVariable("post_id") Long id,HttpServletResponse resp, Model model,HttpSession session) throws IOException {
		Post p = PostManager.getInstance().getPosts().get(id);
		File file;
		if(p.getPictureURL()!=null) {
			 file = new File(p.getPictureURL());
		}
		else {

			file = new File("C:\\travelBook\\logo1.png");
		}
		Files.copy(file.toPath(), resp.getOutputStream());
	}
	@RequestMapping(value="/video/{post_id:.+}", method=RequestMethod.GET)
	@ResponseBody
	public void viewPostVideo( @PathVariable("post_id") Long id,HttpServletResponse resp, Model model,HttpSession session) throws IOException {
		Post p = PostManager.getInstance().getPosts().get(id);
		File file;
		if(p.getVideoURL()!=null) {
			 file = new File(p.getVideoURL());
		}
		else {

			file = new File("C:\\travelBook\\logo1.png");
		}
		Files.copy(file.toPath(), resp.getOutputStream());
	}
	
	@RequestMapping(value="/uploadPicture", method=RequestMethod.POST)
	public String receiveUpload(@RequestParam("picture") MultipartFile multiPartFile,HttpServletResponse response, Model model,HttpServletRequest request, HttpSession session) {
	try {
		String username = (String) session.getAttribute("username");
		
		User u = UsersManager.getInstance().getRegisteredUsers().get(username);
		if(u.getPhotoURL()!=null) {
			File usersPicture = new File(UsersManager.getInstance().getRegisteredUsers().get(username).getPhotoURL());
			usersPicture.delete();
		}
		File fileOnDisk = new File(FILE_LOCATION + username+"-profile-pic."+multiPartFile.getContentType().split("/")[1]);
		Files.copy(multiPartFile.getInputStream(), fileOnDisk.toPath(), StandardCopyOption.REPLACE_EXISTING);
		UsersManager.getInstance().addProfilePic(username, fileOnDisk.getAbsolutePath());
		model.addAttribute("profilePic", fileOnDisk.getAbsolutePath());
		errorMsg= "Picture successfully uploaded!";
		/*response.setStatus(200);
		response.getWriter().append("Picture successfully uploaded!");*/

	} catch (IOException e) {
		errorMsg="Picture failed to upload!";
		e.printStackTrace();
	}
	model.addAttribute("errorMsg", errorMsg);
	errorMsg=null;
	
	return "updateInfo";
		
	
}
}
