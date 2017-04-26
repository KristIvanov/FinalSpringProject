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

<body>
<c:set var="usersprofile" scope="session" value="${usersprofile.username }"></c:set>

  <jsp:include page="header2.jsp" />
        <div id="head4">
          <div class="container">
          
        
<!-- view picture -->
                  <img class="profilepic" src="/MyTravelerProject/image/${usersprofile.username }" align="middle" height=300 width="300"> <br>

<script src="https://code.jquery.com/jquery-1.7.1.js" type="text/javascript"></script>
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
<script>
$(document).ready(function(){
	   
	$("#btn").click(function(e){
		e.preventDefault();
	    
	    if($("#btn").hasClass('following')){

	        //$.ajax(); Do Unfollow
	        $.post("/MyTravelerProject/unfollow");
	        $("#btn").removeClass('following');
	        $("#btn").removeClass('unfollow');
	        $("#btn").text('Follow');
	    } else {

	        // $.ajax(); Do Follow
	        $.post("/MyTravelerProject/follow");
	        $("#btn").removeClass('following');
	        $("#btn").text('Following');
	    }
	    
	});
	$( "div.container" )
	  .mouseover(function() {
		  if($("#btn").hasClass('following')){
		  $("#btn").addClass('unfollow');
			$("#btn").text('Unfollow');
		  }
	  })
	  .mouseout(function() {
		  if($("#btn").hasClass('following')){
		  $("#btn").removeClass('unfollow');
			$("#btn").text('Following');
		  }
	  });
	
});

</script>



<!-- print username, first, last, email -->

	<h2 class="lead"><c:out value="${ usersprofile.username }"></c:out>
	</h2>
	<c:if test="${sessionScope.username != null && sessionScope.username != usersprofile.username}">
	<div id = "btn" >
    <button class="btn followButton" rel="6">Follow</button>
</div>
</c:if>
	<p> <font size="5" face="Book Antiqua" color="black" > 
		First name: 	
              
					<c:out value="${ usersprofile.first_name }"></c:out> <br>
       Last name:
					<c:out value="${ usersprofile.last_name }"></c:out> <br>
       Email:
					<c:out value="${ usersprofile.email }"></c:out> <br>
                    </font></p>
<!-- nqkyde vsqsno butoni POSTS FOLLOWING FOLLOWERS -->


<div id="wall" align="center"></div>
<button class="btn-default" id="postShow">Posts</button>
<button class="btn-default" id="followersShow">Followers</button>
<button class = "btn-default" id="followingShow">Following</button>


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
	<c:forEach var="string" items="${usersprofile.followers}">
		<div class="postlook" align="center">
				<!-- show small Picture -->
				<img src="/MyTravelerProject/image/<c:url value="${ string }"></c:url>" height=30 width="30"/> <br>
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "/MyTravelerProject/user/<c:out value="${string}"/> " >${ string }</a><br>
				
				
		</div><br>
	</c:forEach>
</div>


<div hidden id="printedFollowing" align="center">
	<c:forEach var="string" items="${usersprofile.following}">
		<div class="postlook" align="center">
				<!-- show small Picture -->
				<img src="/MyTravelerProject/image/<c:url value="${ string }"></c:url>" height=30 width="30"/> <br>
				<!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
				<a href = "/MyTravelerProject/user/<c:out value="${string}"/> " >${ string }</a><br>
				
				
		</div><br>
	</c:forEach>
	</div>
	</div>
	</div>
</div>
 
</body>
</html>