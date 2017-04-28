package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.TreeSet;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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

	private static String jspName = "indexx";
	private static String errorMsg = " ";
	private static final String PICTURES_LOCATION = "C:\\travelBook\\postsPics\\";
	private static final String VIDEOS_LOCATION = "C:\\travelBook\\postsVideos\\";

	
	
	@RequestMapping(value="/addPost",method = RequestMethod.POST)
	public String addPost(Model model,@RequestParam("picture") MultipartFile multiPartPicture,@RequestParam("video") MultipartFile multiPartVideo, HttpServletRequest req,HttpSession session, HttpServletResponse response) throws IOException {
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
		getAllPosts(model, session);
		jspName = "allPosts";
		model.addAttribute("errorMsg", errorMsg);
		errorMsg=null;
		removeCacheFromResponse(response);
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
	public String addComment(Model model, HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		if(session.getAttribute("username") != null ) {
			String commentText = request.getParameter("newComment").trim();
			String username = (String) session.getAttribute("username");
			Long postId = (Long) session.getAttribute("postId"); //or maybe set the post id as parameter of the request
			
			model.addAttribute("text", commentText);
			
			try {
				validateData(commentText);
				User author = UsersManager.getInstance().getRegisteredUsers().get(username);
				LocalDateTime date = LocalDateTime.now();
				CommentDAO.getInstance().addNewComment(new Comment(author, commentText, postId, date));
				if(session.getAttribute("url") != null) {
					if(session.getAttribute("postId") != null) {
						Long id = (Long) session.getAttribute("postId");
						Post p = PostManager.getInstance().getPosts().get(id);
						model.addAttribute("post",p);
						jspName= "post";
					}
				}
			} catch (InvalidInputException e) {
				jspName= "post";
			}
		}
	else {
		jspName = "login";
	}
		model.addAttribute("errorMsg", errorMsg);
		errorMsg=null;
		removeCacheFromResponse(response);
		return jspName;
	}
	
	@RequestMapping(value="/quickSearch",method = RequestMethod.GET)
	public String products(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String words = request.getParameter("searchFor").trim();
		session.setAttribute("searchFor", words);
		String[] keywords = words.split(" ");
		List<Post> resultsByTag = PostManager.getInstance().searchByTags(keywords);
		List<Post> resultsByDestination = PostManager.getInstance().searchByDestination(words);
		List<Post> allPostsByUser = PostManager.getInstance().searchByUser(words);
		List<User> resultsByUser = UsersManager.getInstance().searchUser(words);
		HashSet<Post> allPosts = new HashSet<>();//to keep only unique posts
		allPosts.addAll(resultsByTag);
		allPosts.addAll(resultsByDestination);
		allPosts.addAll(allPostsByUser);
		List<Post> results = new ArrayList<>(allPosts);
		session.setAttribute("results", results);
		session.setAttribute("resultsByUser", resultsByUser);
		jspName="searchResults";
		removeCacheFromResponse(response);
		return jspName;
	}
	
	@RequestMapping(value="/searchByTag",method = RequestMethod.GET)
	public String productsTag(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String words = (String)session.getAttribute("searchFor");
		String[] keywords = words.split(" ");
		List<Post> resultsByTag = PostManager.getInstance().searchByTags(keywords);
		List<Post> tagsByDate = PostManager.getInstance().orderByDate(resultsByTag);
		session.setAttribute("results", tagsByDate);
		jspName="searchResults";
		removeCacheFromResponse(response);
		return jspName;
	}
	
	@RequestMapping(value="/searchByDest",method = RequestMethod.GET)
	public String productsDest(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String words = (String)session.getAttribute("searchFor");
		List<Post> resultsByDestination = PostManager.getInstance().searchByDestination(words);
		List<Post> destinationByDate = PostManager.getInstance().orderByDate(resultsByDestination);
		session.setAttribute("results", destinationByDate);
		jspName="searchResults";
		removeCacheFromResponse(response);
		return jspName;
	}
	
	@RequestMapping(value="/searchByAuthor",method = RequestMethod.GET)
	public String productsAuthor(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String words = (String)session.getAttribute("searchFor");
		List<Post> allPostsByUser = PostManager.getInstance().searchByUser(words);
		List<Post> usersByDate = PostManager.getInstance().orderByDate(allPostsByUser);
		session.setAttribute("results", usersByDate);
		jspName="searchResults";
		removeCacheFromResponse(response);
		return jspName;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/orderByDate",method = RequestMethod.GET)
	public String productsByDate(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<Post> results = (List<Post>) session.getAttribute("results");
		List<Post> ByDate = PostManager.getInstance().orderByDate(results);
		session.setAttribute("results", ByDate);
		jspName="searchResults";
		removeCacheFromResponse(response);
		return jspName;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/orderByLikes",method = RequestMethod.GET)
	public String productsByLikes(Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<Post> results = (List<Post>) session.getAttribute("results");
		List<Post> ByLikes = PostManager.getInstance().orderByDate(results);
		session.setAttribute("results", ByLikes);
		jspName="searchResults";
		removeCacheFromResponse(response);
		return jspName;
	}
	
	
	
	@RequestMapping(value="/post/{postId} ",method = RequestMethod.GET)
	public String viewPost(Model model, @PathVariable("postId") String id,  HttpServletResponse response, HttpSession session) {
		Long postId = Long.parseLong(id);
		Post post = PostManager.getInstance().getPosts().get(postId);
		model.addAttribute("post", post);
		session.setAttribute("post", post);
		if (session.getAttribute("username")!=null){
			model.addAttribute("isLiked", post.isLikedFrom((String)session.getAttribute("username")));
		}
		removeCacheFromResponse(response);
		return "post";
	}
	
	
	
	@RequestMapping(value="/likePost", method=RequestMethod.POST)
	public String likePost(Model model, HttpSession session) {
		System.out.println("like-vame");
		Post post = (Post) session.getAttribute("post");
		User user = UsersManager.getInstance().getRegisteredUsers().get(session.getAttribute("username"));
		if (UsersManager.getInstance().getRegisteredUsers().containsKey(session.getAttribute("username"))){
			if (!post.isLikedFrom(user.getUsername())){
				post.like(user);
				PostManager.getInstance().likePost(post, user);
			}
			
		}
		return "post";
	}
	
	@RequestMapping(value="/dislikePost", method=RequestMethod.POST)
	public String dislikePost(Model model, HttpSession session) {
		System.out.println("dislike-vame");
		Post post = (Post) session.getAttribute("post");
		User user = UsersManager.getInstance().getRegisteredUsers().get(session.getAttribute("username"));
		if (UsersManager.getInstance().getRegisteredUsers().containsKey(session.getAttribute("username"))){
			post.dislike(user);
			PostManager.getInstance().dislike(post, user);
		}
		return "post";
	}
	@RequestMapping(value="/allPosts", method=RequestMethod.GET)
	public String getAllPosts(Model model, HttpSession session) {
		TreeSet<Post> posts = new TreeSet<>((Post p1, Post p2)->p2.getDate().compareTo(p1.getDate()));
		
		for(Post p : PostManager.getInstance().getPosts().values()) {	
			
			posts.add(p);
		}
		model.addAttribute("posts",posts);
		return "allPosts";
	}
	
	@RequestMapping(value="/topPosts", method=RequestMethod.GET)
	public String getTopPosts(Model model, HttpSession session) {
		//TreeSet<Post> posts = new TreeSet<>((Post p1, Post p2)->p2.getLikes() - p1.getLikes());
		List<Post> posts = new ArrayList<>();
		for(Post p : PostManager.getInstance().getPosts().values()) {	
			posts.add(p);
		}
		posts.sort(new Comparator<Post>() {

			@Override
			public int compare(Post o1, Post o2) {
				if (o1.getLikes() == o2.getLikes()){
					if (o1.getPostId() > o2.getPostId()) return 1;
					else return -1;
				}
				return o2.getLikes() - o1.getLikes();
			}
		});
		model.addAttribute("posts",posts);
		return "topPosts";
	}
	
	private  void validateData(String text) throws InvalidInputException{
		if(text == null || text.isEmpty()) {
			errorMsg = "Empty comment text!";
			throw new InvalidInputException("Empty comment text!");
		}
	
	}
	
	private  void removeCacheFromResponse(HttpServletResponse response) {
		response.setHeader("Pragma", "No-cache");
		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-control", "no-cache");
	}
	
}
