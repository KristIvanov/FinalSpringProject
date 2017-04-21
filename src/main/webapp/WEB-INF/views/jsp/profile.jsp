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
<script type="text/javascript">
<!-- TODO set autoshow -->
	function printPosts()
	{	
		$.ajax({
		    url: 'printPosts',
		    type: 'GET',
		    success: function(result){
	   			document.getElementById("printedPosts").innerHTML  = result;
    			}
		});
	}
</script>
<script type="text/javascript">
	function printFollowers()
	{	
		$.ajax({
		    url: 'printFollowers',
		    type: 'GET',
		    success: function(result){
	   			document.getElementById("ajaxResponse").innerHTML  = result;
    			}
		});
	}
</script>
<script type="text/javascript">
	function printFollowing()
	{	
		$.ajax({
		    url: 'printFollowing',
		    type: 'GET',
		    success: function(result){
	   			document.getElementById("ajaxResponse").innerHTML  = result;
    			}
		});
	}
</script>
<body>
<jsp:include page="header.jsp" />
	<br>
	<br>
<!-- check if !userexists ? return user not found.jsp -->
<!-- view picture -->

<img src="/MyTravelerProject/image/<c:url value="${ usersprofile.username }"></c:url>" height=300 width="300"/> <br>

<!-- print username, first, last, email -->
<table border="1" id="userInfo">
				<tr>
				 <p>username: <c:out value="${ usersprofile.username }"></c:out> </p>
					
				</tr>
                <tr>
                <p>first name: <c:out value="${ usersprofile.first_name }"></c:out></p>		
				</tr>
                <tr>
                 <p>last name: <c:out value="${ usersprofile.last_name }"></c:out></p>
				</tr>
                <tr>
                 <p>email: <c:out value="${ usersprofile.email }"></c:out></p>
                </tr>
		</table>
<!-- nqkyde vsqsno butoni POSTS FOLLOWING FOLLOWERS -->
<div>
	<input type="submit" onclick="printPosts()" value = "Posts">
	<input type="submit" onclick="printFollowers()" value = "Followers">
	<input type="submit" onclick="printFollowing()" value = "Following">
</div>

<!-- tablica kato newsfeed, koqto se zapylva sprqmo gornite butoni -->
<table border="1" id="printedPosts">
	<c:forEach var="post" items="${usersprofile.posts}"> 
				<tr>
					<c:out value="${ post.date }"></c:out>
                    <p>date</p>
				</tr>
                <tr>
					<c:out value="${ post.category }"></c:out>
                    <p>category</p>
				</tr>
                <tr>
					<c:out value="${ post.postName }"></c:out>
                    <p>name</p>
				</tr>
                <tr>
					<c:out value="${ post.description }"></c:out>
                    <p>desc</p>
                </tr>
                <tr>
					<c:out value="${ post.likers.size }"></c:out>
                    <p>likes</p>
                </tr>
                <tr>
                	<c:forEach var="Comment" items="${post.comments}"> 
						<c:out value="${ comment }"></c:out>
                   	 	<p>comments</p>
                   	</c:forEach>
                </tr>
			</c:forEach>
</table>
</body>
</html>