package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.model.Category;
import com.example.model.Comment;
import com.example.model.InvalidInputException;
import com.example.model.Post;
import com.example.model.User;
import com.example.model.dbModel.CategoryDAO;
import com.example.model.dbModel.CommentDAO;
import com.example.model.dbModel.DBManager;
import com.example.model.managers.PostManager;
import com.example.model.managers.UsersManager;

@Controller
@MultipartConfig
public class PostsController {

	private static String jspName = "index";
	private static String errorMsg = " ";
	private static final String PICTURES_LOCATION = "C:\\travelBook\\postsPics\\";
	private static final String VIDEOS_LOCATION = "C:\\travelBook\\postsVideos\\";

	
	
	@RequestMapping(value="/addPost",method = RequestMethod.POST)
	public String addPost(Model model,@RequestParam("picture") MultipartFile multiPartPicture,@RequestParam("video") MultipartFile multiPartVideo, HttpServletRequest req,HttpSession session) throws IOException {
		if(session.getAttribute("username") != null ) {
			String postName = req.getParameter("postname").trim();
			String username = (String) req.getSession().getAttribute("username");
			String postdescription = req.getParameter("postdescription").trim();
			String categoryName = req.getParameter("category");
			LocalDateTime date = LocalDateTime.now();
			String destinationName = req.getParameter("destinationname").trim();
			String longitude = req.getParameter("longitude");
			String latitude = req.getParameter("latitude");
			String hashtags = req.getParameter("hashtags").trim();
			String[] keywords = hashtags.split(" ");
	        String postPicUrl=null;
			if(multiPartPicture.getSize() != 0) {
				int numberOfPosts = PostManager.getInstance().getPosts().size()+1;
				File fileOnDisk = new File(PICTURES_LOCATION + "id=" + numberOfPosts+"post-pic" +"."+ multiPartPicture.getContentType().split("/")[1]);
				Files.copy(multiPartPicture.getInputStream(), fileOnDisk.toPath(), StandardCopyOption.REPLACE_EXISTING);
				postPicUrl = fileOnDisk.getAbsolutePath();
			}
			
			String postVideoUrl=null;
			if(multiPartVideo.getSize() != 0) {
				int numberOfPosts = PostManager.getInstance().getPosts().size()+1;
				File fileOnDisk = new File(VIDEOS_LOCATION + "id=" + numberOfPosts+"post-video" +"."+ multiPartVideo.getContentType().split("/")[1]);
				Files.copy(multiPartVideo.getInputStream(), fileOnDisk.toPath(), StandardCopyOption.REPLACE_EXISTING);
				postVideoUrl = fileOnDisk.getAbsolutePath();
			}
			
			
			//saving old inputs in session to have filled inputs if something was invalid
			model.addAttribute("postname", postName);
			model.addAttribute("postdescription", postdescription);
			model.addAttribute("category", categoryName);
			model.addAttribute("destinationname", destinationName);
			model.addAttribute("longitude", longitude);
			model.addAttribute("latitude", latitude);
			model.addAttribute("hashtags", hashtags);
	
			
			try {
				this.validateData(postName,postdescription,destinationName,longitude,latitude);
				PreparedStatement ps = DBManager.getInstance().getConnection().prepareStatement("SELECT category_id FROM categories WHERE name=?");
				ps.setString(1, categoryName);
				ResultSet rs = ps.executeQuery();
				rs.next();
				Long categoryId = rs.getLong("category_id");
				Category category = CategoryDAO.getInstance().getALlCategoriesByID().get(categoryId);
				PostManager.getInstance().addNewPost(postName, username, postdescription, category, date, destinationName, NumberUtils.toDouble(longitude), NumberUtils.toDouble(latitude),postPicUrl, keywords,postVideoUrl);
			} catch (InvalidInputException e) {
				jspName= "addPost";
			} catch (SQLException e) {
				jspName= "addPost";
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
		}
		else {
			jspName = "login";
		}
		model.addAttribute("errorMsg", errorMsg);
		return jspName;
	}
	
	private  void validateData(String postName, String postDescription, String destinationName,String longitude, String latitude) throws InvalidInputException{
		if(postName == null || postName.isEmpty()) {
			errorMsg = "Invalid post name!";
			throw new InvalidInputException("Invalid post name!");
		}
		if(!checkString(postDescription)) {
			errorMsg = "Invalid post description!";
			throw new InvalidInputException("Invalid post description!");
		}
		if(!checkString(destinationName)) {
			errorMsg = "Invalid destination name!";
			throw new InvalidInputException("Invalid destination name!");
		}
		if(!NumberUtils.isParsable(longitude)) {
			errorMsg = "Invalid longitude!";
			throw new InvalidInputException("Invalid longitude!");
		}
		if(!NumberUtils.isParsable(latitude)) {
			errorMsg = "Invalid latitude!";
			throw new InvalidInputException("Invalid latitude!");
		}
	}
	
	private boolean checkString(String name) {
		if (name != null && !name.isEmpty()) {
			return true;
		}
		return false;
	}

	
	@RequestMapping(value="/addComment",method = RequestMethod.POST)
	public String addComment(Model model, HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("username") != null ) {
			String commentText = request.getParameter("text").trim();
			String username = (String) session.getAttribute("username");
			Long postId = (Long) request.getAttribute("postId"); //or maybe set the post id as parameter of the request
			
			model.addAttribute("text", commentText);
			
			try {
				validateData(commentText);
				User author = UsersManager.getInstance().getRegisteredUsers().get(username);
				Post post = PostManager.getInstance().getPosts().get(postId);
				LocalDateTime date = LocalDateTime.now();
				CommentDAO.getInstance().addNewComment(new Comment(author, commentText, post, date));
			} catch (InvalidInputException e) {
				jspName= "addPost";
			}
		}
	else {
		jspName = "login";
	}
	
		return jspName;
	}
	
	@RequestMapping(value="/quickSearch",method = RequestMethod.GET)
	public String products(Model model, HttpSession session, HttpServletRequest request) {
		String words = request.getParameter("searchFor").trim();
		String[] keywords = words.split(" ");
		List<Post> resultsByTag = PostManager.getInstance().searchByTags(keywords);
		List<Post> resultsByDestination = PostManager.getInstance().searchByDestination(words);
		List<Post> allPostsByUser = PostManager.getInstance().searchByUser(words);
		List<Post> tagsByDate = PostManager.getInstance().orderByDate(resultsByTag);
		List<Post> tagsByLikes = PostManager.getInstance().orderByLikes(resultsByTag);
		List<Post> destinationByDate = PostManager.getInstance().orderByDate(resultsByDestination);
		List<Post> destinationByLikes = PostManager.getInstance().orderByLikes(resultsByDestination);
		List<User> resultsByUser = UsersManager.getInstance().searchUser(words);
		session.setAttribute("resultsByTag", resultsByTag);
		session.setAttribute("resultsByDestination", resultsByDestination);
		session.setAttribute("resultsByUser", resultsByUser);
		session.setAttribute("tagsByDate", tagsByDate);
		session.setAttribute("tagsByLikes", tagsByLikes);
		session.setAttribute("destinationByDate", destinationByDate);
		session.setAttribute("destinationByLikes", destinationByLikes);
		session.setAttribute("postsByAuthor", allPostsByUser);
		jspName="searchResults";
		return jspName;
	}
	
	private  void validateData(String text) throws InvalidInputException{
		if(text == null || text.isEmpty()) {
			errorMsg = "Empty comment text!";
			throw new InvalidInputException("Empty comment text!");
		}
	
	}
	
}
