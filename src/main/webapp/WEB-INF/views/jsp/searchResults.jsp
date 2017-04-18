<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Results</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script>
$(document).ready(function(){
    $("#btn1").click(function(){
        $("#test1").html(document.getElementById("printByTags").innerHTML);
    });
    $("#btn2").click(function(){
        $("#test1").html(document.getElementById("printByDestination").innerHTML);
    });
    $("#btn3").click(function(){
        $("#test1").html(document.getElementById("postsByAuthor").innerHTML);
    });
    $("#btn4").click(function(){
        $("#test1").html(document.getElementById("printByUser").innerHTML);
    });
});
</script>
</head>
<body>

<jsp:include page="header.jsp" />
	<br>
	<br>

<button id="btn1">Posts by tags</button>
<button id="btn2">Posts by destination</button>
<button id="btn3">Posts by author</button>
<button id="btn4">Users</button>
<br>
<button id="btn5">Order by date</button>
<button id="btn6">Order by likes</button>

<div id="test1" align="center"></div>

<div hidden id="printByTags" align="center">
	<h1>Posts tagged with: <c:out value="${sessionScope.searchFor}"></c:out></h1>
	<c:if test="${sessionScope.resultsByTag==null || sessionScope.resultsByTag.isEmpty()}">
	<br><br><h2 align="center">No posts found</h2>
	</c:if>
	<c:forEach var="post" items="${sessionScope.resultsByTag}">
		<div class="postlook" align="center">
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "/user/<c:out value="${post.author.username}"/> " >${ post.author.username }</a><br>
				
				
				<c:out value="${ post.author.first_name }"></c:out>
			    <c:out value="${ post.author.last_name }"></c:out>
	             
				<c:out value="${ post.date }"></c:out>
				<c:out value="${ post.category }"></c:out>
		
				<c:out value="${ post.postName }"></c:out>
	             <p>postname</p><br>
		
				<c:out value="${ post.description }"></c:out>
	             <p>desc</p><br>
	            
				<!-- TODO ADD LIKES -->
	             <p>likes</p><br>
	           
	             <c:forEach var="Comment" items="${post.comments}"> 
						<c:out value="${ comment }"></c:out><br>
	                	<p>comments</p><br>
	             </c:forEach>
		</div><br>
	</c:forEach>
</div>

<div hidden id="printByDestination" align="center">
	<h1>Posts with destination: <c:out value="${sessionScope.searchFor}"></c:out></h1>
	<c:if test="${sessionScope.resultsByDestination==null || sessionScope.resultsByDestination.isEmpty()}">
	<br><br><h2 align="center">No destinations found</h2>
	</c:if>
	<c:forEach var="post" items="${sessionScope.resultsByDestination}">
		<div class="postlook" align="center">
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "/user/<c:out value="${post.author.username}"/> " >${ post.author.username }</a><br>
				
				
				<c:out value="${ post.author.first_name }"></c:out>
			    <c:out value="${ post.author.last_name }"></c:out>
	             
				<c:out value="${ post.date }"></c:out>
				<c:out value="${ post.category }"></c:out>
		
				<c:out value="${ post.postName }"></c:out>
		
				<c:out value="${ post.description }"></c:out>
	             <p>desc</p><br>
	            
				<!-- TODO add likes -->
	             <p>likes</p><br>
	           
	             <c:forEach var="Comment" items="${post.comments}"> 
						<c:out value="${ comment }"></c:out><br>
	                	<p>comments</p><br>
	             </c:forEach>
		</div><br>
	</c:forEach>
</div>

<div hidden id="postsByAuthor" align="center">
	<h1>Posts by author: <c:out value="${sessionScope.searchFor}"></c:out></h1>
	<c:if test="${sessionScope.postsByAuthor==null || sessionScope.postsByAuthor.isEmpty()}">
	<br><br><h2 align="center">No posts with such author found</h2>
	</c:if>
	<c:forEach var="post" items="${sessionScope.postsByAuthor}">
		<div class="postlook" align="center">
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "/user/<c:out value="${post.author.username}"/> " >${ post.author.username }</a><br>
				
				
				<c:out value="${ post.author.first_name }"></c:out>
			    <c:out value="${ post.author.last_name }"></c:out>
	             
				<c:out value="${ post.date }"></c:out>
				<c:out value="${ post.category }"></c:out>
		
				<c:out value="${ post.postName }"></c:out>
		
				<c:out value="${ post.description }"></c:out>
	             <p>desc</p><br>
	            
				<!-- TODO add likes -->
	             <p>likes</p><br>
	           
	             <c:forEach var="Comment" items="${post.comments}"> 
						<c:out value="${ comment }"></c:out><br>
	                	<p>comments</p><br>
	             </c:forEach>
		</div><br>
	</c:forEach>
</div>

<div hidden id="printByUser" align="center">
	<h1>Users: <c:out value="${sessionScope.searchFor}"></c:out></h1>
	<c:if test="${sessionScope.resultsByUser==null || sessionScope.resultsByUser.isEmpty()}">
	<br><br><h2 align="center">No users found</h2>
	</c:if>
	<c:forEach var="user" items="${sessionScope.resultsByUser}">
		<div class="postlook" align="center">
				<!-- show small Picture -->
				
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "/user/<c:out value="${user.username}"/> " >${ post.author.username }</a><br>
				
				<c:out value="${ user.first_name }"></c:out>
			    <c:out value="${ user.last_name }"></c:out>
	             
				<c:out value="${ user.email }"></c:out>
				
		</div><br>
	</c:forEach>
</div>
</body>
</html>