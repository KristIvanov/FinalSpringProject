package com.example.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.example.model.managers.UsersManager;


public class User {
	
	
	private long userId;
	private String username;
	private String password;
	private String email;
	private String first_name;
	private String last_name;
	private String photoURL;
	private HashSet<String> followers;
	private HashSet<String> following;
	private ArrayList<Post> posts;
	private String aboutMe;
	
	
	public User(String username, String password, String first_name, String last_name, String email) throws InvalidInputException {
		if(checkString(username)) {
			this.username = username;
		}
		else {
			throw new InvalidInputException("Invalid username!");
		}
		if(password!=null && !password.isEmpty()) {//cannot use regex validation here because the hashed pass would be different
			this.password = password;
		}
		else {
			throw new InvalidInputException("Invalid password!");
		}
		if(validateEmailAddress(email)) {
			this.email = email;
		}
		else {
			throw new InvalidInputException("Invalid email!");
		}
		if(checkString(first_name)) {
			this.first_name = first_name;
		}
		else {
			throw new InvalidInputException("Invalid firstName!");
		}
		if(checkString(last_name)) {
			this.last_name = last_name;
		}
		else {
			throw new InvalidInputException("Invalid lastName!");
		}
		followers = new HashSet<>();
		following = new HashSet<>();
		posts = new ArrayList<>();
		
	}
	
	
	
	public long getUserId() {
		return userId;
	}


	public void setUserId(long userId) {
		this.userId = userId;
	}


	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public String getPhotoURL() {
		return photoURL;
	}

	public void setPhotoURL(String photoURL) {
		this.photoURL = photoURL;
	}

	public Set<String> getFollowers() {
		return Collections.unmodifiableSet(followers);
	}

	public Set<String> getFollowing() {
		return Collections.unmodifiableSet(following);
	}

	public List<Post> getPosts() {
		List<Post> postove = posts;
		Collections.sort(posts, (Post p1, Post p2) -> p2.getDate().compareTo(p1.getDate()));
		return Collections.unmodifiableList(postove);
	}

	
	public String getAboutMe() {
		return aboutMe;
	}
	
	public void setAboutMe(String aboutMe) {
		if (aboutMe!=null && !aboutMe.isEmpty()){
			this.aboutMe = aboutMe;		}
	}
	
	public void addPost(Post p) {
		this.posts.add(p);
	}

	private boolean checkString(String name) {
		if (name != null && !name.isEmpty()) {
			return true;
		}
		return false;
	}

	
	private boolean validateEmailAddress(String email) {
        String ePattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$";
        java.util.regex.Pattern p = java.util.regex.Pattern.compile(ePattern);
        java.util.regex.Matcher m = p.matcher(email);
        return m.matches();
	}

	public void follow(String following){
		if (!this.doesFollow(following)){
			this.following.add(following);
			User u = UsersManager.getInstance().getRegisteredUsers().get(following);
			u.followers.add(this.username);
		}
	}
	
	public void unfollow(String following){
		if (this.doesFollow( following)){
			User u = UsersManager.getInstance().getRegisteredUsers().get(following);
			u.followers.remove(this.username);
			this.following.remove(u.username);
		}
	}
	
	public boolean doesFollow(String following){
		return this.following.contains(following);
	}



	public void addFollowing(String following) {
		this.following.add(following);
}
	
	public void addFollower(String follower) {
		this.followers.add(follower);
}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (userId ^ (userId >>> 32));
		return result;
	}



	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		if (userId != other.userId)
			return false;
		return true;
	}

	
	
	
	

}
