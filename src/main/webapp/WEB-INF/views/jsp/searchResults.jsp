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
      
      <!-- TODO REMOVE FORMS AND REFRESH CONTENT OF RESULTS THROUGH AJAX -->
         $(document).ready(function(){
         	    $("#test1").html(document.getElementById("results").innerHTML);
         	    
             $("#btn1").click(function(){
            	 $.get("/MyTravelerProject/searchByTag");
            	 $("#test1").html(document.getElementById("results").innerHTML);
             });
             $("#btn2").click(function(){
            	 $.get("/MyTravelerProject/searchByDest");
                 $("#test1").html(document.getElementById("results").innerHTML);
             });
             $("#btn3").click(function(){
            	 $.get("/MyTravelerProject/searchByAuthor");
                 $("#test1").html(document.getElementById("results").innerHTML);
             });
             $("#btn4").click(function(){
                 $("#test1").html(document.getElementById("printByUser").innerHTML);
             });
         });
      </script> 
       <style>
   .forms { display:inline-block;}</style>
   </head>
   <body>
  
      <jsp:include page="header2.jsp" />
      <header id="head4">
         <div class="container">
            <div class="row">
            	<div class="forms" >
            	<p>
            	<form class="forms" action="/MyTravelerProject/searchByTag"><button class="btn btn-action btn-lg" id="btn1">Posts by tags</button></form>
            	<form class="forms" action="/MyTravelerProject/searchByDest"> <button class="btn btn-action btn-lg" id="btn2">Posts by destination</button></form>
            	<form class="forms" action="/MyTravelerProject/searchByAuthor"> <button class="btn btn-action btn-lg" id="btn3">Posts by author</button></form>
            	 </p>
            	
            	</div>
               <button class="btn btn-action btn-lg" id="btn4">Users</button>
               <div id="test1" align="center"></div>
               <div>
               		<div hidden id="results" align="center">
		                  <h1 class="lead"> Posts tagged with: 
		                     <c:out value="${sessionScope.searchFor}"></c:out>
		                  <c:if test="${sessionScope.results==null || sessionScope.results.isEmpty()}">
		                     <br><br>
		                     No posts found
		                  </c:if>
		                  </h1>
		                  <c:if test="${sessionScope.results!=null && !sessionScope.results.isEmpty()}">

						<form class="forms" action="/MyTravelerProject/orderByDate"> <button class="btn btn-action btn-lg"id="btn11">Newest</button></form>
						<form class="forms" action="/MyTravelerProject/orderByLikes"> <button class="btn btn-action btn-lg" id="btn12">Top</button></form>
	                   </c:if>
	                   <c:forEach var="post" items="${sessionScope.results}">
	                      <div >
	                         <img class="img-circle-users" src="image/<c:url value="${post.author.username}"/>">
	                         <font style= "oblique" size="5" style="color:black;">
	                            <a href = "user/<c:url value="${post.author.username}"/>" >${ post.author.username }</a> posted on ${post.date} <br>
	                         </font>
	                         <a class="lead" style="color:blue" href = "post/
	                         <c:url value="${post.postId}"/>" >${ post.postName }</a> <br><br>
	                         <img src="picture/${post.postId}" height="300" >
	                         <h5>${ post.likes } likes</h5>
	                      </div>
	                      <br>
	                  </c:forEach>
				</div>
                <div hidden id="printByUser" align="center">
					<h1 class="lead"> Users containing: 
						<c:out value="${sessionScope.searchFor}"></c:out>
							<c:if test="${sessionScope.resultsByUser==null || sessionScope.resultsByUser.isEmpty()}">
							<br><br>
							No results found
						</c:if>
					</h1>
                    <c:forEach var="user" items="${sessionScope.resultsByUser}">
                        <div class="postlook" align="center">
			                   <!-- show small Picture -->
			                   <img class="img-circle-users" src="image/<c:url value="${user.username}"/>">
			                   <a href = "/MyTravelerProject/user/<c:url value="${user.username}"/>" >${ user.username }</a><br>
			                   <c:out value="${ user.first_name }"></c:out>
			                   <c:out value="${ user.last_name }"></c:out> <br>
			                   <c:out value="${ user.email }"></c:out>
            			</div>
                		<br>
             		</c:forEach>
				</div>
                  <br>
               </div>
               <br>
            </div>
         </div>
      </header>
   </body>
</html>