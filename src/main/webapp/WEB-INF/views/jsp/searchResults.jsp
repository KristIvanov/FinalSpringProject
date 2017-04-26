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
   </head>
   <body>
      <jsp:include page="header2.jsp" />
      <header id="head4">
         <div class="container">
            <div class="row">
               <button class="btn" id="btn1">Posts by tags</button>
               <button class="btn" id="btn2">Posts by destination</button>
               <button class="btn" id="btn3">Posts by author</button>
               <button class="btn" id="btn4">Users</button>
               <div id="test1" align="center">
                  <h1 class="lead"> Posts tagged with: 
                     <c:out value="${sessionScope.searchFor}"></c:out>
                  <c:if test="${sessionScope.results==null || sessionScope.results.isEmpty()}">
                     <br><br>
                     No posts found
                  </c:if>
                  </h1>
                  <script>
                     $("#btn11").click(function(){
                    	 	$.get("/MyTravelerProject/orderByDate");
                        	$("#test1").html(document.getElementById("results").innerHTML);
                        });
                        $("#btn12").click(function(){
                        	$.get("/MyTravelerProject/orderByLikes");
                        	$("#test1").html(document.getElementById("results").innerHTML);
                        });
                        
                  </script>
                  <button class="btn" id="btn11">Newest</button>
                  <button class="btn" id="btn12">Top</button>
                  <div id="results" align="center">
                     <c:forEach var="post" items="${sessionScope.results}">
                        <div >
                           <img class="img-circle-users" src="image/<c:url value="${post.author.username}"/>">
                           <font style= "oblique" size="5" style="color:black;">
                              <a href = "user/<c:url value="${post.author.username}"/>" >${ post.author.username }</a> posted on ${post.date} <br>
                           </font>
                           <a class="lead" style="color:blue" href = "post/<c:url value="${post.postId}"/>" >${ post.postName }</a> <br><br>
                           <img src="picture/${post.postId}" height="300" >
                           <h5>${ post.likes } likes</h5>
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