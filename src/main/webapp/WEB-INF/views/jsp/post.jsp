<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page errorPage="errorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <title>Post</title>
      <style>
        .mapmodal {
      display: none; /* Hidden by default */
      position: fixed; /* Stay in place */
      z-index: 1; /* Sit on top */
      padding-top: 200px; /* Location of the box */
      left: 0; 
      top: 0;
      width: 100%; /* Full width */
      height: 100%; /* Full height */
      overflow: auto; /* Enable scroll if needed */
      background-color: rgb(0,0,0); /* Fallback color */
      background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
      }
      /* Modal Content */
      .mapmodal-content {
      background-color: #fefefe;
      margin: auto;
      padding: 20px;
      border: 1px solid #888;
      width: 70%;
      }
       .close1 {
      color: #aaaaaa;
      float: right;
      font-size: 32px;
      font-weight: bold;
      }
         #map {
         height: 40%;
         width:50%;
         }
      </style>
   </head>
   <body>
      <jsp:include page="header2.jsp" />
      <header id="head4">
            <div class="lead" >
               <c:out value="${ post.postName }"></c:out>
            </div>
            <div class="postCategory" >
               Category:<c:out value="${ post.category.name }"></c:out>, Place:<c:out value="${post.destination }"></c:out> <br>
               <button id="mapBtn">Click to see on map</button>
            </div>
            <!-- TODO post pic and video! if no pic - default pic -->
            <div class="authorMoreInfo" >
               <img class="img-circle-users" src="/MyTravelerProject/image/
               <c:url value="${post.author.username}"/>">
               <a href = "/MyTravelerProject/user/<c:url value="${post.author.username}"/>" >${ post.author.username }</a> posted on ${post.date} <br>
            </div>
            <div > <img src="/MyTravelerProject/picture/${post.postId}" height="300" >
            </div>
            <div class="postDesc" >
               <c:out value="${ post.description } "></c:out>
            </div>
            <!-- TODO like only if logged -->
            <div class="postLikes">
               <!--<c:out value="${ post.likes } 5"></c:out>
                  <!-- Open List With People Who Like This Post -->
               <c:if test=""></c:if>
               <button id="likesBtn">${ post.likes } likes</button><br>
               <c:if test="${ sessionScope.username != null }">
               
	               <c:if test="${sessionScope.username !=null && !isLiked}">
	               
	                  <div class="container">
	                     <button id="btn" class="btn likeButton" rel="6">Like</button>
	                  </div>
	               </c:if>
	               <c:if test="${sessionScope.username !=null && isLiked}">
	                  <div id="btn1" class="container">
	                     <button class="btn likeButton" rel="6">Dislike</button>
	                  </div>
	               </c:if>

               </c:if>
            </div>
            <div class="postComments">
               <c:if test="${post.commentssize==0}">
                  <p>No comments!</p>
               </c:if>
               <c:if test="${post.commentssize>0}">
                  <p>Comments:</p>
                  <c:forEach var="Comment" items="${post.comments}">
                     <a href = "/MyTravelerProject/user/
                     <c:url value="${post.author.username}"/>" >${ post.author.username } </a>
                     Commented on:<c:out value="${ Comment.date }"></c:out> <br>
                     <c:out value="${ Comment.text }"></c:out><br>
                  </c:forEach>
               </c:if>
            </div>
            <div id="addComment">
               <c:if test="${ sessionScope.username == null }">
                  <p>to add comments and like, please log in first!<p>
                     <a class="btn" href="/MyTravelerProject/login">Login</a>
               </c:if>
               <c:if test="${ sessionScope.username != null }">
               <form action="/MyTravelerProject/addComment" method="post" >
               Add new comment: <br><textarea id="textarea"name="newComment" value="${newComment }" cols="50" rows="8" placeholder="Add comment"  required></textarea></br>
               <input type="submit" value = "Add comment" name="text"></br>
               </form>
               </c:if>
            </div>
            <div id="map">
                     <input id="longitude" hidden type="text" value="${ post.longitude }" name="longitude" >
                     <input id="latitude" hidden type="text" value="${ post.latitude }" name="latitude" >
                  </div>
            <div id="mapModal" class="mapmodal">
               <!-- Modal content -->
               <div class="mapmodal-content">
                  <span class="close1">&times;</span>
                  <div id="map">
                     <input id="longitude" hidden type="text" value="${ post.longitude }" name="longitude" >
                     <input id="latitude" hidden type="text" value="${ post.latitude }" name="latitude" >
                  </div>
               </div>
               </div>
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
                        </div>
                        <br>
                     </c:forEach>
                  </div>
               </div>
      </header>
      <c:set var="url" scope="session" value="post/"></c:set>

      <c:set var="postId" scope="session" value="${post.postId}"></c:set>
     <script>    // Get the modal
     var mapModal = document.getElementById('mapModal');
     
     // Get the button that opens the modal
     var mapBtn = document.getElementById("mapBtn");
     
     // Get the <span> element that closes the modal
     var mapSpan = document.getElementsByClassName("close1")[0];
     $("#mapModal").on('shown.bs.modal', function () {initAutocomplete();});
     // When the user clicks the button, open the modal 
     mapBtn.onclick = function() {
         mapModal.style.display = "block";
         initAutocomplete();
     }
     
     // When the user clicks on <span> (x), close the modal
     mapSpan.onclick = function() {
         mapModal.style.display = "none";
     }
     
     // When the user clicks anywhere outside of the modal, close it
     window.onclick = function(event) {
         if (event.target == mapModal) {
             mapModal.style.display = "none";
         }
     }</script>
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
      


	<script src="https://code.jquery.com/jquery-1.7.1.js" type="text/javascript"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<script>
		
		$(document).ready(function(){
			   
			$("#btn").click(function(e){
				e.preventDefault();
				
				
				
			    if($("#btn").hasClass('liked')){
		
			        //$.ajax(); Do Dislike
			        $.post("/MyTravelerProject/dislikePost");
			        $("#btn").removeClass('liked');
			        $("#btn").addClass('dislike');
			        $("#btn").text('like');
			    } else {
		
			        // $.ajax(); Do Like
			        
			        $.post("/MyTravelerProject/likePost");
			        $("#btn").addClass('liked');
			        $("#btn").text('liked');
			    }
			    
			});
			$( "div.container" )
			  .mouseover(function() {
				  if($("#btn").hasClass('liked')){
				  $("#btn").addClass('dislike');
					$("#btn").text('Dislike');
				  }
			  })
			  .mouseout(function() {
				  if($("#btn").hasClass('liked')){
				  $("#btn").removeClass('dislike');
					$("#btn").text('Liked');
				  }
			  });
			
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
         src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBN0sPhqPEf8YKqPYO862QcMihJmO0xb5s&callback=initMap"></script>
      <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBN0sPhqPEf8YKqPYO862QcMihJmO0xb5s&libraries=places&callback=initAutocomplete"
         async defer></script>
      </div>
   </body>
</html>