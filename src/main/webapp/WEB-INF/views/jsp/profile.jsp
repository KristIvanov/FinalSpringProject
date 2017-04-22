<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ page errorPage="errorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script>
$(document).ready(function(){
    $("#postShow").click(function(){
        $("#wall").html(document.getElementById("printedPosts").innerHTML);
    });
    $("#followersShow").click(function(){
        $("#wall").html(document.getElementById("printedFollowers").innerHTML);
    });
    $("#followingShow").click(function(){
        $("#wall").html(document.getElementById("printedFollowing").innerHTML);
    });
   
    
});
</script>
<body>
  <jsp:include page="header2.jsp" />
        
        <br><br><br><br><br><br><br><br>
<!-- check if !userexists ? return user not found.jsp -->
<!-- view picture -->

<img src="/MyTravelerProject/image/<c:url value="${ usersprofile.username }"></c:url>" height=300 width="300"/> <br>

<!-- print username, first, last, email -->
<table border="1" id="userInfo">
				<tr>
					<c:out value="${ usersprofile.username }"></c:out>
                    <p>username</p>
				</tr>
                <tr>
					<c:out value="${ usersprofile.first_name }"></c:out>
                    <p>first name</p>
				</tr>
                <tr>
					<c:out value="${ usersprofile.last_name }"></c:out>
                    <p>last name</p>
				</tr>
                <tr>
					<c:out value="${ usersprofile.email }"></c:out>
                    <p>email</p>
                </tr>
		</table>
<!-- nqkyde vsqsno butoni POSTS FOLLOWING FOLLOWERS -->
<div id="wall" align="center"></div>
<button id="postShow">Posts</button>
<button id="followersShow">Followers</button>
<button id="followingShow">Following</button>


<div hidden id="printedPosts" align="center">
		<c:forEach var="post" items="${usersprofile.posts}">
		<div class="postlook" align="center">
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "<c:url value="/${user.username}"/>" >${ post.author.username }</a><br>
				<img src="image/<c:url value="${ user.username }"></c:url>" height=30 width="30"/> <br>
				
				<c:out value="${ post.author.first_name }"></c:out>
			    <c:out value="${ post.author.last_name }"></c:out>
			    
	            
		</div><br>
	</c:forEach>
</div>

<div hidden id="printedFollowers" align="center">
	<c:forEach var="user" items="${usersprofile.followers}">
		<div class="postlook" align="center">
				<!-- show small Picture -->
				<img src="image/<c:url value="${ user.username }"></c:url>" height=30 width="30"/> <br>
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "/user/<c:out value="${user.username}"/> " >${ user.username }</a><br>
				
				<c:out value="${ user.first_name }"></c:out>
			    <c:out value="${ user.last_name }"></c:out>
	             
				<c:out value="${ user.email }"></c:out>
				
		</div><br>
	</c:forEach>
</div>


<div hidden id="printedFollowing" align="center">
	<c:forEach var="user" items="${usersprofile.following}">
		<div class="postlook" align="center">
				<!-- show small Picture -->
				<img src="image/<c:url value="${ user.username }"></c:url>" height=30 width="30"/> <br>
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "/user/<c:out value="${user.username}"/> " >${ user.username }</a><br>
				
				<c:out value="${ user.first_name }"></c:out>
			    <c:out value="${ user.last_name }"></c:out>
	             
				<c:out value="${ user.email }"></c:out>
				
		</div><br>
	</c:forEach>
</div>

</body>
</html>