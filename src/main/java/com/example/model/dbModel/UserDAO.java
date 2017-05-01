package com.example.model.dbModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import com.example.model.InvalidInputException;
import com.example.model.User;


public class UserDAO {
	
  private static UserDAO instance=new UserDAO();
  
  private UserDAO() {}
  
  public static synchronized UserDAO getInstance() {
    if (instance == null) {
      instance = new UserDAO();
    }
    return instance;
  }
  
  public  Set<User> getAllUsers() throws SQLException {
	synchronized (DBManager.getInstance()) {
		
			Set<User> users = new HashSet<User>();
			Connection con = DBManager.getInstance().getConnection();
	    try {
	    	//get all users
	    	Statement userST = con.createStatement();
	    	ResultSet usersRS = userST.executeQuery("SELECT user_id,username,password,first_name,last_name,email,pictureURL FROM users;");
	      	while (usersRS.next()) {
	      		User u = new User(	usersRS.getString("username"), 
	      							usersRS.getString("password"), 
	      							usersRS.getString("first_name"), 
	      							usersRS.getString("last_name"), 
	      							usersRS.getString("email"));  //TODO hash pass);
	      		users.add(u);
	      		
	      		//set user's id
	      		u.setUserId(usersRS.getLong("user_id"));
	      		//set user's picture if there is one
	      		String pictureUrl ="";
	      		if((pictureUrl=usersRS.getString("pictureURL"))!=null) {
	      			u.setPhotoURL(pictureUrl);
	      		}
	      		
	      		
		    	String followersSQL = "SELECT follower_id FROM users_has_followers WHERE user_id=?";
		    	String followingSQL = "SELECT user_id FROM users_has_followers WHERE follower_id=?";

		    	
		    	//get user's followers
		    	PreparedStatement followersPS = con.prepareStatement(followersSQL);
		    	followersPS.setLong(1, u.getUserId());
		    	ResultSet followersRS = followersPS.executeQuery();
		    	while(followersRS.next()) {
		    		long followerId = followersRS.getLong("follower_id");
		    		PreparedStatement followerName = con.prepareStatement("SELECT username FROM users WHERE user_id=?");
		    		followerName.setLong(1, followerId);
		    		ResultSet rs = followerName.executeQuery();
		    		rs.next();
		    		String follower = rs.getString("username");
		    		u.addFollower(follower);
		    	}
		    	//get user's following
		    	PreparedStatement followingPS = con.prepareStatement(followingSQL);
		    	followingPS.setLong(1, u.getUserId());
		    	ResultSet followingRS = followingPS.executeQuery();
		    	while(followingRS.next()) {
		    		long followingId = followingRS.getLong("user_id");
		    		PreparedStatement followingName = con.prepareStatement("SELECT username FROM users WHERE user_id=?");
		    		followingName.setLong(1, followingId);
		    		ResultSet rs = followingName.executeQuery();
		    		rs.next();
		    		String following = rs.getString("username");
		    		u.addFollowing(following);
}
		    	followersPS.close();
		    	followersRS.close();
		    	
		    	
	      	}
	      	userST.close();
		    usersRS.close();
	    }
	    catch (SQLException e) {
	    	System.out.println("Cannot make statement." + e.getMessage());
	    	throw e;
	    } catch (InvalidInputException e) {
			e.printStackTrace();
		} 
	    
	    System.out.println("Users loaded successfully");
	    
		return Collections.unmodifiableSet(users);
	}
  }
  
  public void saveUser(User user) throws SQLException {
      PreparedStatement st;
	try {
		st = DBManager.getInstance().getConnection().prepareStatement("INSERT INTO users (username,password,first_name,last_name,email) VALUES (?,?,?,?,?);",Statement.RETURN_GENERATED_KEYS);
	    st.setString(1, user.getUsername());
	    st.setString(2, user.getPassword());
	    st.setString(3, user.getFirst_name());
	    st.setString(4, user.getLast_name());
	    st.setString(5, user.getEmail());
	    st.executeUpdate();
	    ResultSet res = st.getGeneratedKeys();
		res.next();
		long id = res.getLong(1);
		user.setUserId(id);
	    System.out.println("User added successfully");
	    res.close();
	    st.close();
	} catch (SQLException e) {
		System.out.println(e.getMessage());
		throw e;
	}
  }
  
  public  void deleteUser(User u) throws SQLException {
	  PreparedStatement prepSt;
	  try {
		prepSt = DBManager.getInstance().getConnection().prepareStatement("DELETE FROM users WHERE user_id=?");
		prepSt.setLong(1, u.getUserId());
		prepSt.executeUpdate();
		prepSt.close();
		System.out.println("A user successfully deleted!");
	  } catch (SQLException e) {
		 System.out.println(e.getMessage());
		 throw e;
	  }
  }
  
  
  public synchronized void updateUser(User u) throws SQLException{
	  
	  Connection con = DBManager.getInstance().getConnection();
	  try {
		  con.setAutoCommit(false);
		  PreparedStatement prepSt;
		  prepSt = con.prepareStatement("UPDATE users SET first_name = ? WHERE user_id=?");
		  prepSt.setString(1, u.getFirst_name());
		  prepSt.setLong(2, u.getUserId());
		  prepSt.executeUpdate();
		  
		  prepSt = con.prepareStatement("UPDATE users SET last_name = ? WHERE user_id=?");
		  prepSt.setString(1, u.getLast_name());
		  prepSt.setLong(2, u.getUserId());
		  prepSt.executeUpdate();
		  
		  prepSt = con.prepareStatement("UPDATE users SET email = ? WHERE user_id=?");
		  prepSt.setString(1, u.getEmail());
		  prepSt.setLong(2, u.getUserId());
		  prepSt.executeUpdate();
		  
		  prepSt = con.prepareStatement("UPDATE users SET username = ? WHERE user_id=?");
		  prepSt.setString(1, u.getUsername());
		  prepSt.setLong(2, u.getUserId());
		  prepSt.executeUpdate();
		  prepSt.close();
		  con.commit();
	} catch (SQLException e) {
		try {
			con.rollback();
		} catch (SQLException e1) {
			System.out.println("wtf");
		}
		throw e;
	} finally {
		try {
			con.setAutoCommit(true);
		} catch (SQLException e) {
			System.out.println("wtf");
		}
	}
  }

  public void updatePass(String hashPassword, User u) throws SQLException {
	  Connection con = DBManager.getInstance().getConnection();
	  PreparedStatement prepSt = null;
	  u.setPassword(hashPassword);
	  try {
		prepSt = con.prepareStatement("UPDATE users SET password = ? WHERE user_id=?");
		prepSt.setString(1, hashPassword);
		prepSt.setLong(2, u.getUserId());
		prepSt.executeUpdate();
		prepSt.close();
	  } catch (SQLException e) {
		  System.out.println("sql pass change failed");
		  throw e;
	  }
	}
  
  public void updateAboutMe(String aboutMe, User u) throws SQLException{
	  Connection con = DBManager.getInstance().getConnection();
	  PreparedStatement prepSt = null;
	  u.setAboutMe(aboutMe);
	  try {
		prepSt = con.prepareStatement("UPDATE users SET aboutMe = ? WHERE user_id=?");
		prepSt.setString(1, aboutMe);
		prepSt.setLong(2, u.getUserId());
		prepSt.executeUpdate();
		prepSt.close();
	} catch (SQLException e) {
		System.out.println("sql pass change failed");
		throw e;
	}
	  
  }
  
  public void addProfilePic(User u) throws SQLException {
	  Connection con = DBManager.getInstance().getConnection();
	  PreparedStatement prepSt = null;
	  try {
		prepSt=con.prepareStatement("UPDATE users SET pictureURL = ? WHERE user_id=?");
		prepSt.setString(1, u.getPhotoURL());
		prepSt.setLong(2, u.getUserId());
		prepSt.executeUpdate();
		prepSt.close();
	} catch (SQLException e) {
		System.out.println("Adding picture url failed!" + e.getMessage());
		throw e;
	}
	  
  }
  
  public void follow(User follower, User following) throws SQLException {
	  
	  Connection con = DBManager.getInstance().getConnection();
	  PreparedStatement prepSt = null;
	  try {
		prepSt= con.prepareStatement("INSERT INTO users_has_followers (user_id,follower_id) VALUES (?,?)");
		prepSt.setLong(1, following.getUserId());
		prepSt.setLong(2, follower.getUserId());
		prepSt.executeUpdate();
	  } catch (SQLException e) {
		e.printStackTrace();
		throw e;
	}
	  
  }
public void unFollow(User follower, User following) throws SQLException {
	  
	  Connection con = DBManager.getInstance().getConnection();
	  PreparedStatement prepSt = null;
	  try {
		prepSt= con.prepareStatement("DELETE FROM users_has_followers where user_id=? and follower_id=?");
		prepSt.setLong(1, following.getUserId());
		prepSt.setLong(2, follower.getUserId());
		prepSt.executeUpdate();
	  } catch (SQLException e) {
		e.printStackTrace();
		throw e;
	}
	  
  }
  
  //TODO remove user from followers when user deletes his profile
}
