<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Post</title>
<style>
/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
}

/* The Close Button */
.close {
    color: #aaaaaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}
</style>
</head>


<body>
<div class="postLarge" align="center">
	<div class="postName" align="center">
		<c:out value="${ post.postName }"></c:out>
	</div>
	<div class="postCategory" align="center">
		<c:out value="${ post.category }"></c:out>
	</div>
	<div class="authorAndDate" align="center">
		<c:out value="${ post.author.first_name } "></c:out>
		<c:out value="${ post.author.last_name } * "></c:out>
		<c:out value="${ post.date } "></c:out>
	</div>
	<div class="authorMoreInfo" align="center">
		<a href = "<c:url value="/${post.author.username}"/>" >${ post.author.username } </a><br>
		<img src="image/<c:url value="${ post.author.username }"></c:url>" height=30 width="30"/> <br>
	</div>
	<div class="postDesc" align="center">
		<c:out value="${ post.description } "></c:out>
	</div>
	<div class="postLikes">
		<!--<c:out value="${ post.likes } 5"></c:out>
		<!-- Open List With People Who Like This Post -->
		<button id="likesBtn">${ post.likes } likes</button>
	</div>
	<div class="postComments">
               	<p>comments</p><br>
               	<p>comments</p><br>
		<c:forEach var="Comment" items="${post.comments}"> 
			<c:out value="${ comment }"></c:out><br>
        </c:forEach>
	</div>
    <div id="addComment">
    	<c:if test="${ sessionScope.username == null }">
			<p>to add comments, please log in first!<p>
			<form action="login" method="get">
				<input type="submit" value="login">
			</form>
		</c:if>
		<c:if test="${ sessionScope.username != null }">
			<form action="addComment" method="post" >
				Enter comment:<textarea name="newComment" value="${newComment }" cols="50" rows="8" placeholder="Add comment"  required></textarea></br>
				<input type="submit" value = "Add comment" name="text"></br>
				<input type="hidden" value="<c:out value="${post.id}"/>" name="postId">
			</form>
		</c:if>
    </div>

	
	
	<!-- The Modal -->
	<div id="myModal" class="modal">
	
	  <!-- Modal content -->
	  <div class="modal-content">
	    <span class="close">&times;</span>
	    <c:forEach var="User" items="${post.likers}"> 
			<div class="userlook" align="center">
				<!-- show small Picture -->
				<img src="image/<c:url value="${ user.username }"></c:url>" height=30 width="30"/> <br>
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "<c:url value="/${user.username}"/>" >${ post.author.username }</a><br>
				
				<c:out value="${ user.first_name }"></c:out>
			    <c:out value="${ user.last_name }"></c:out>
	             
				<c:out value="${ user.email }"></c:out>
				
			</div><br>
        </c:forEach>
	  </div>
	
	</div>
	
	<script>
	// Get the modal
	var modal = document.getElementById('myModal');
	
	// Get the button that opens the modal
	var btn = document.getElementById("likesBtn");
	
	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];
	
	// When the user clicks the button, open the modal 
	btn.onclick = function() {
	    modal.style.display = "block";
	}
	
	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	    modal.style.display = "none";
	}
	
	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	    if (event.target == modal) {
	        modal.style.display = "none";
	    }
	}
	</script>
</div>
</body>
</html>