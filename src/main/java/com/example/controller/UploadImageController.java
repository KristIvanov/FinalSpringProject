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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.model.User;
import com.example.model.managers.UsersManager;


@Controller
@MultipartConfig
public class UploadImageController {

	private static final String FILE_LOCATION = "C:\\travelBook\\usersProfilePics\\";
	
	

	@RequestMapping(value="/image", method=RequestMethod.GET)
	@ResponseBody
	public void viewPicture(HttpServletResponse resp, Model model,HttpSession session) throws IOException {
		String username = (String) session.getAttribute("username");
		User u = UsersManager.getInstance().getRegisteredUsers().get(username);
		File file;
		if(u.getPhotoURL()!=null) {
			System.out.println(u.getPhotoURL());
			 file = new File(u.getPhotoURL());
		}
		else {

			file = new File("C:\\travelBook\\usersProfilePics\\No_person.jpg");
		}
		Files.copy(file.toPath(), resp.getOutputStream());
	}
	
	@RequestMapping(value="/uploadPicture", method=RequestMethod.POST)
	public String receiveUpload(@RequestParam("picture") MultipartFile multiPartFile,HttpServletResponse response, Model model,HttpServletRequest request, HttpSession session) throws IOException{
		String username = (String) session.getAttribute("username");
		String extension = request.getParameter("extension");
	//	if(UsersManager.getInstance().getRegisteredUsers().get(username).getPhotoURL()!=null) {
		//	File usersPicture = new File(UsersManager.getInstance().getRegisteredUsers().get(username).getPhotoURL());
		//	usersPicture.delete();
		//}
		File fileOnDisk = new File(FILE_LOCATION + username+"-profile-pic."+extension);
		Files.copy(multiPartFile.getInputStream(), fileOnDisk.toPath(), StandardCopyOption.REPLACE_EXISTING);
		model.addAttribute("profilePic", fileOnDisk.getAbsolutePath());
		System.out.println(fileOnDisk.getAbsolutePath());
		response.setStatus(200);
		response.getWriter().append("Picture successfully uploaded!");
		//TODO figure out why the ajax is not working as it supposed to be?!?!?
		return "updateInfo";
	}
}
