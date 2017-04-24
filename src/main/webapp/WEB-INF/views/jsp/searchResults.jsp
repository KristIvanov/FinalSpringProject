
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
	    $("#test1").html(document.getElementById("printByTags").innerHTML);
        $("#postsByTags").html(document.getElementById("printByTagsOrderNewest").innerHTML);
    $("#btn1").click(function(){
        $("#test1").html(document.getElementById("printByTags").innerHTML);
        $("#postsByTags").html(document.getElementById("printByTagsOrderNewest").innerHTML);
    });
    $("#btn2").click(function(){
        $("#test1").html(document.getElementById("printByDestination").innerHTML);
        $("#postsByDestination").html(document.getElementById("printByDestOrderNewest").innerHTML);
    });
    $("#btn3").click(function(){
        $("#test1").html(document.getElementById("printByAuthor").innerHTML);
        $("#postsByUsers").html(document.getElementById("printByUserOrderNewest").innerHTML);
    });
    $("#btn4").click(function(){
        $("#test1").html(document.getElementById("printByUser").innerHTML);
    });
    
});
</script>
</head>
<body>

  <jsp:include page="header2.jsp" />
       <header id="head4">
         <div class="container">
            <div class="row">
<button id="btn1">Posts by tags</button>
<button id="btn2">Posts by destination</button>
<button id="btn3">Posts by author</button>
<button id="btn4">Users</button>

<div id="test1" align="center"></div>

<div hidden id="printByTags" align="center">
	<h1>Posts tagged with: <c:out value="${sessionScope.searchFor}"></c:out></h1>
	<c:if test="${sessionScope.tagsByDate==null || sessionScope.tagsByDate.isEmpty()}">
	<br><br><h2 align="center">No posts found</h2>
	</c:if>
	<script>
	$("#btn11").click(function(){
    	$("#test1").html(document.getElementById("printByTags").innerHTML);
        $("#postsByTags").html(document.getElementById("printByTagsOrderNewest").innerHTML);
    });
    $("#btn12").click(function(){
    	$("#test1").html(document.getElementById("printByTags").innerHTML);
        $("#postsByTags").html(document.getElementById("printByTagsOrderTop").innerHTML);
    });
    </script>
	<button id="btn11">Newest</button>
	<button id="btn12">Top</button>
	<div id="postsByTags" align="center"><p>printbytagsdiv</p><br></div>
	
	<div hidden id="printByTagsOrderNewest" align="center">
		<c:forEach var="post" items="${sessionScope.tagsByDate}">
		<div class="postlook" align="center">
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "user/<c:url value="${post.author.username}"/> " >${ post.author.username }</a><br>
				<img src="image/<c:url value="${ post.author.username }"></c:url>" height=30 width="30"/> <br>
				
				<c:out value="${ post.author.first_name }"></c:out>
			    <c:out value="${ post.author.last_name }"></c:out>
	             
				<c:out value="${ post.date }"></c:out>
				<c:out value="${ post.category.name }"></c:out>
		
				<c:out value="${ post.postName }"></c:out>
		
				<c:out value="${ post.description }"></c:out>
	            
				<c:out value="${ post.likes }"></c:out>
	           
	             <c:forEach var="Comment" items="${post.comments}"> 
						<c:out value="${ comment }"></c:out><br>
	                	<p>comments</p><br>
	             </c:forEach>
		</div><br>
	</c:forEach>
	</div>
	
	<div hidden id="printByTagsOrderTop" align="center">
		<c:forEach var="post" items="${sessionScope.tagsByLikes}">
		<div class="postlook" align="center">
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "user/<c:url value="${post.author.username}"/>" >${ post.author.username }</a><br>
				<img src="image/<c:url value="${ post.author.username }"></c:url>" height=30 width="30"/> <br>
				
				<c:out value="${ post.author.first_name }"></c:out>
			    <c:out value="${ post.author.last_name }"></c:out>
	             
				<c:out value="${ post.date }"></c:out>
				<c:out value="${ post.category.name }"></c:out>
		
				<c:out value="${ post.postName }"></c:out>
		
				<c:out value="${ post.description }"></c:out>
	            
				<c:out value="${ post.likes }"></c:out>
	           
	             <c:forEach var="Comment" items="${post.comments}"> 
						<c:out value="${ comment }"></c:out><br>
	                	<p>comments</p><br>
	             </c:forEach>
		</div><br>
	</c:forEach>
	</div>
</div>



<div hidden id="printByDestination" align="center">
	<h1>Posts tagged with: <c:out value="${sessionScope.searchFor}"></c:out></h1>
	<c:if test="${sessionScope.tagsByDate==null || sessionScope.tagsByDate.isEmpty()}">
	<br><br><h2 align="center">No posts found</h2>
	</c:if>
	<script>
	$("#btn21").click(function(){
        $("#postsByDestination").html(document.getElementById("printByDestOrderNewest").innerHTML);
    });
    $("#btn22").click(function(){
        $("#postsByDestination").html(document.getElementById("printByDestOrderTop").innerHTML);
    });
    </script>
	<button id="btn21">Newest</button>
	<button id="btn22">Top</button>
	<div id="postsByDestination" align="center"></div>
	
	<div hidden id="printByDestOrderNewest" align="center">
		<c:forEach var="post" items="${sessionScope.destinationByDate}">
		<div class="postlook" align="center">
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "user/<c:url value="${post.author.username}"/>" >${ post.author.username }</a><br>
				<img src="image/<c:url value="${ post.author.username }"></c:url>" height=30 width="30"/> <br>
				
				<c:out value="${ post.author.first_name }"></c:out>
			    <c:out value="${ post.author.last_name }"></c:out>
	             
				<c:out value="${ post.date }"></c:out>
				<c:out value="${ post.category.name }"></c:out>
		
				<c:out value="${ post.postName }"></c:out>
		
				<c:out value="${ post.description }"></c:out>
	            
				<c:out value="${ post.likes }"></c:out>
	           
	             <c:forEach var="Comment" items="${post.comments}"> 
						<c:out value="${ comment }"></c:out><br>
	                	<p>comments</p><br>
	             </c:forEach>
		</div><br>
	</c:forEach>
	</div>
	
	<div hidden id="printByDestOrderTop" align="center">
		<c:forEach var="post" items="${sessionScope.destinationByLikes}">
		<div class="userlook" align="center">
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "user/<c:url value="/${post.author.username}"/>" >${ post.author.username }</a><br>
				<img src="image/<c:url value="${ post.author.username }"></c:url>" height=30 width="30"/> <br>
				
				<c:out value="${ post.author.first_name }"></c:out>
			    <c:out value="${ post.author.last_name }"></c:out>
	             
				<c:out value="${ post.date }"></c:out>
				<c:out value="${ post.category.name }"></c:out>
		
				<c:out value="${ post.postName }"></c:out>
		
				<c:out value="${ post.description }"></c:out>
	            
				<c:out value="${ post.likes }"></c:out>
	           
	             <c:forEach var="Comment" items="${post.comments}"> 
						<c:out value="${ comment }"></c:out><br>
	                	<p>comments</p><br>
	             </c:forEach>
		</div><br>
	</c:forEach>
	</div>
</div>



<div hidden id="printByAuthor" align="center">
	<h1>Posts tagged with: <c:out value="${sessionScope.searchFor}"></c:out></h1>
	<c:if test="${sessionScope.usersByDate==null || sessionScope.usersByDate.isEmpty()}">
	<br><br><h2 align="center">No posts found</h2>
	</c:if>
	<script>
	 $("#btn31").click(function(){
	    $("#postsByUsers").html(document.getElementById("printByUserOrderNewest").innerHTML);
	 });
	 $("#btn32").click(function(){
	    $("#postsByUsers").html(document.getElementById("printByUserOrderTop").innerHTML);
	 });
    </script>
	<button id="btn31">Newest</button>
	<button id="btn32">Top</button>
	<div id="postsByUsers" align="center"></div>
	
	<div hidden id="printByUserOrderNewest" align="center">
		<c:forEach var="post" items="${sessionScope.usersByDate}">
		<div class="postlook" align="center">
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "user/<c:url value="${post.author.username}"/>" >${ post.author.username }</a><br>
				<img src="image/<c:url value="${ post.author.username }"></c:url>" height=30 width="30"/> <br>
				
				<c:out value="${ post.author.first_name }"></c:out>
			    <c:out value="${ post.author.last_name }"></c:out>
	             
				<c:out value="${ post.date }"></c:out>
				<c:out value="${ post.category.name }"></c:out>
		
				<c:out value="${ post.postName }"></c:out>
		
				<c:out value="${ post.description }"></c:out>
	            
				<c:out value="${ post.likes }"></c:out>
	           
	             <c:forEach var="Comment" items="${post.comments}"> 
						<c:out value="${ comment }"></c:out><br>
	                	<p>comments</p><br>
	             </c:forEach>
		</div><br>
	</c:forEach>
	</div>
	
	<div hidden id="printByUserOrderTop" align="center">
		<c:forEach var="post" items="${sessionScope.usersByLikes}">
		<div class="postlook" align="center">
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "user/<c:url value="${post.author.username}"/> " >${ post.author.username }</a><br>
				<img src="image/<c:url value="${ post.author.username }"></c:url>" height=30 width="30"/> <br>
				
				<c:out value="${ post.author.first_name }"></c:out>
			    <c:out value="${ post.author.last_name }"></c:out>
	             
				<c:out value="${ post.date }"></c:out>
				<c:out value="${ post.category.name }"></c:out>
		
				<c:out value="${ post.postName }"></c:out>
		
				<c:out value="${ post.description }"></c:out>
	            
				<c:out value="${ post.likes }"></c:out>
	           
	             <c:forEach var="Comment" items="${post.comments}"> 
						<c:out value="${ comment }"></c:out><br>
	                	<p>comments</p><br>
	             </c:forEach>
		</div><br>
	</c:forEach>
	</div>
</div>

<div hidden id="printByUser" align="center">
	<h1>Users: <c:out value="${sessionScope.searchFor}"></c:out></h1>
	<c:if test="${sessionScope.resultsByUser==null || sessionScope.resultsByUser.isEmpty()}">
	<br><br><h2 align="center">No users found</h2>
	</c:if>
	<c:forEach var="user" items="${sessionScope.resultsByUser}">
		<div class="postlook" align="center">
				<!-- show small Picture -->
				<img src="image/<c:url value="${ user.username }"></c:url>" height=30 width="30"/> <br>
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "user/<c:url value="${user.username}"/>" >${ post.author.username }</a><br>
				
				<c:out value="${ user.first_name }"></c:out>
			    <c:out value="${ user.last_name }"></c:out>
	             
				<c:out value="${ user.email }"></c:out>
				
		</div><br>
	</c:forEach>
</div>
</div>
         </div>
      </header>
</body>
</html>

   