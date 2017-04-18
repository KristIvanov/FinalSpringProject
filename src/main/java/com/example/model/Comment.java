package com.example.model;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class Comment {
	
	private long comment_id;
	private User author;
	private String text;
	private Post post;
	private LocalDateTime date;
	private HashSet<User> likedBy;

	
	public Comment(User author, String text,Post post,LocalDateTime date) throws InvalidInputException {
		this.author = author;
		this.post=post;
		this.date=date;
		if(checkString(text)) {
			this.text = text;
		}
		else {
			throw new InvalidInputException("Invalid comment text!");
		}
	}
	
	
	
	public Post getPost() {
		return post;
	}

	public long getComment_id() {
		return comment_id;
	}


	public void setComment_id(long comment_id) {
		this.comment_id = comment_id;
	}
	public LocalDateTime getDate() {
		return date;
	}

	public int getLikes() {
		return likedBy.size();
	}
	
	public Set<User> getLikers() {
		return Collections.unmodifiableSet(likedBy);
	}
	
	public void like(User u){
		likedBy.add(u);
	}
	public void dislike(User u) {
		if(likedBy.contains(u)) {
			likedBy.remove(u);
		}
	}


	public User getAuthor() {
		return author;
	}

	public String getText() {
		return text;
	}

	private boolean checkString(String name) {
		if (name != null && !name.isEmpty()) {
			return true;
		}
		return false;
	}
	
	
	
	

}
