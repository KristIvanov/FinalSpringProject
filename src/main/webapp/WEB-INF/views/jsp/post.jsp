<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Post</title>
<style>

/* Always set the map height explicitly to define the size of the div
         * element that contains the map. */
         #map {
         height: 50%;
         width:50%;
         }
         /* Optional: Makes the sample page fill the window. */
         html, body {
         height: 100%;
         margin: 0;
         padding: 0;
         }
</style>
</head>


<body>
<jsp:include page="header2.jsp" />
      <header id="head4">
         <div class="container">
            <div class="row">
<div class="postLarge" align="center">
	<div class="postName" align="center">
		<c:out value="${ post.postName }"></c:out>
	</div>
	<div class="postCategory" align="center">
		<c:out value="${ post.category.name }"></c:out>
	</div>
	<div class="authorAndDate" align="center">
		<c:out value="${ post.author.first_name } "></c:out>
		<c:out value="${ post.author.last_name } * "></c:out>
	</div>
	<!-- TODO post pic and video! if no pic - default pic -->
	<div class="authorMoreInfo" align="center">
          <a href = "/MyTravelerProject/user/<c:url value="${post.author.username}"/>" >${ post.author.username }</a> posted on ${post.date} <br>
         <img class="img-circle-users" src="/MyTravelerProject/image/<c:url value="${post.author.username}"/>">
	</div>
	<div class="postDesc" align="center">
		<c:out value="${ post.description } "></c:out>
	</div>
	<!-- TODO like only if logged -->
	<div class="postLikes">
		<!--<c:out value="${ post.likes } 5"></c:out>
		<!-- Open List With People Who Like This Post -->
		<c:if test=""></c:if>
		<button id="likesBtn">${ post.likes } likes</button>
		      <c:if test="${sessionScope.username !=null }">
		
		<div class="container">
    		<button class="btn likeButton" rel="6">Like</button>
		</div>
		</c:if>
	</div>
	<div class="postComments">
               	<p>comments</p><br>
               	<p>comments</p><br>
		<c:forEach var="Comment" items="${post.comments}"> 
			<a href = "/MyTravelerProject/user/<c:url value="${post.author.username}"/>" >${ post.author.username } </a>
			Commented on: <c:out value="${ Comment.date }"></c:out><br>
			
		
			<c:out value="${ Comment.text }"></c:out><br>
			
			
        </c:forEach>
	</div>
    <div id="addComment">
    	<c:if test="${ sessionScope.username == null }">
			<p>to add comments and like, please log in first!<p>
				<a class="btn" href="/MyTravelerProject/login">Login</a>
		</c:if>
		<c:if test="${ sessionScope.username != null }">
			<form action="/MyTravelerProject/addComment" method="post" >
				Enter comment:<textarea name="newComment" value="${newComment }" cols="50" rows="8" placeholder="Add comment"  required></textarea></br>
				<input type="submit" value = "Add comment" name="text"></br>
			</form>
		</c:if>
    </div>
    <div id="map"></div>
	<input id="longitude" hidden type="text" value="${ post.longitude }" name="longitude" required>
	<input id="latitude" hidden type="text" value="${ post.latitude }" name="latitude" required>

	
	
	<!-- The Modal -->
	<div id="myModal" class="modal">
	
	  <!-- Modal content -->
	  <div class="modal-content">
	    <span class="close">&times;</span>
<c:if test="${post.likes==0}"> Nobody likes this!</c:if>
	    
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
	</div>
         </div>
         </div>
      </header>
      <c:set var="url" scope="session" value="post/"></c:set>
	      <c:set var="postId" scope="session" value="${post.postId}"></c:set>
	
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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<script>
	$('button.likeButton').live('click', function(e){
	    e.preventDefault();
	    $button = $(this);
	    if($button.hasClass('liked')){
	        
	        //$.ajax(); Do Dislike
	        $.post("dislike");
	        $button.removeClass('liked');
	        $button.removeClass('dislike');
	        $button.text('Like');
	    } else {
	        
	        // $.ajax(); Do Like
	        $.post("like");
	        $button.addClass('liked');
	        $button.text('Dislike');
	    }
	});
	
	$('button.likeButton').hover(function(){
	     $button = $(this);
	    if($button.hasClass('liked')){
	        $button.addClass('dislike');
	        $button.text('Dislike');
	    }
	}, function(){
	    if($button.hasClass('liked')){
	        $button.removeClass('dislike');
	        $button.text('Liked');
	    }
	});
	</script>
	
	
	
	<script type="text/javascript">
	function initAutocomplete() {
		var lat = parseFloat(document.getElementById("latitude").value);
	    var lng = parseFloat(document.getElementById("longitude").value);
	    var latLng = new google.maps.LatLng(lat, lng);
	    var map = new google.maps.Map(document.getElementById('map'), {
	      center: latLng,
	      zoom: 10
	    });
	    var marker;
        var infoWindow = new google.maps.InfoWindow;
        var lat = parseFloat(document.getElementById("latitude").value);
        var lng = parseFloat(document.getElementById("longitude").value);
        var latLng = new google.maps.LatLng(lat, lng);
        var marker = new google.maps.Marker({
            map: map,
            position: latLng
        });
        marker.setMap(map);
    }
	</script>
	<script>
         
         function auto_grow(element) {
         element.style.height = "5px";
         element.style.height = (element.scrollHeight)+"px";
         }
    </script>
	<script async defer
    	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBN0sPhqPEf8YKqPYO862QcMihJmO0xb5s&callback=initMap">
	</script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBN0sPhqPEf8YKqPYO862QcMihJmO0xb5s&libraries=places&callback=initAutocomplete"
         async defer>
	</script>
</div>
</body>
</html>