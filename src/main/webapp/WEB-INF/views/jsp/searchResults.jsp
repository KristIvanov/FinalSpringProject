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
               <button class="btn" id="btn1">Posts by tags</button>
               <button class="btn" id="btn2">Posts by destination</button>
               <button class="btn" id="btn3">Posts by author</button>
               <button class="btn" id="btn4">Users</button>
               <div id="test1" align="center"></div>
               <div hidden id="printByTags" align="center">
                  <h1 class="lead"> Posts tagged with: 
                     <c:out value="${sessionScope.searchFor}"></c:out>
                  <c:if test="${sessionScope.tagsByDate==null || sessionScope.tagsByDate.isEmpty()}">
                     <br><br>
                     No posts found
                  </c:if>
                  </h1>
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
                  <button class="btn" id="btn11">Newest</button>
                  <button class="btn" id="btn12">Top</button>
                  <div id="postsByTags" align="center">
                     
                     <br>
                  </div>
                  <div hidden id="printByTagsOrderNewest" align="center">
                     <c:forEach var="post" items="${sessionScope.tagsByDate}">
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
               <div hidden id="printByTagsOrderTop" align="center">
                  <c:forEach var="post" items="${sessionScope.tagsByLikes}">
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
               <br>
            </div>
         </div>
         <div hidden id="printByDestination" align="center">
         <h1 class="lead">
            Posts tagged with: 
            <c:out value="${sessionScope.searchFor}"></c:out>
        
         <c:if test="${sessionScope.destinationByDate==null || sessionScope.destinationByLikes.isEmpty()}">
            <br><br>
            No posts found!
           
         </c:if>
          </h1>
         <script>
            $("#btn21").click(function(){
                   $("#postsByDestination").html(document.getElementById("printByDestOrderNewest").innerHTML);
               });
               $("#btn22").click(function(){
                   $("#postsByDestination").html(document.getElementById("printByDestOrderTop").innerHTML);
               });
               
         </script>
         <button class="btn"id="btn21">Newest</button>
         <button class="btn"id="btn22">Top</button>
         <div id="postsByDestination" align="center"></div>
         <div hidden id="printByDestOrderNewest" align="center">
            <c:forEach var="post" items="${sessionScope.destinationByDate}">
               <div >
                  <img class="img-circle-users" src="image/<c:url value="${post.author.username}"/>">
                  <font style= "oblique" size="5" style="color:black;">
                     <a href = "user/<c:url value="${post.author.username}"/>" >${ post.author.username }</a> posted on ${post.date} <br>
                  </font>
                  <a class="lead" style="color:blue" href = "post/<c:url value="${post.postId}"/>" >${ post.postName }</a> <br><br>
                  <img src="picture/${post.postId}" height="300" >
                  <h5>${ post.likes } likes</h5>
               </div>
            </c:forEach>
         </div>
         <div hidden id="printByDestOrderTop" align="center">
            <c:forEach var="post" items="${sessionScope.destinationByLikes}">
               <div class="userlook" align="center">
                  <div >
                     <img class="img-circle-users" src="image/<c:url value="${post.author.username}"/>">
                     <font style= "oblique" size="5" style="color:black;">
                        <a href = "user/
                        <c:url value="${post.author.username}"/>" >${ post.author.username }</a> posted on ${post.date} <br>
                     </font>
                     <a class="lead" style="color:blue" href = "post/<c:url value="${post.postId}"/>" >${ post.postName }</a> <br><br>
                     <img src="picture/${post.postId}" height="300" >
                     <h5>${ post.likes } likes</h5>
                  </div>
                </div>
            </c:forEach>
            </div>
         </div>
         <div hidden id="printByAuthor" align="center">
            <h1 class="lead">
               Posts tagged with: 
               <c:out value="${sessionScope.searchFor}"></c:out>
            
            <c:if test="${sessionScope.usersByDate==null || sessionScope.usersByDate.isEmpty()}">
               <br><br>
               No posts found
            </c:if>
            </h1>
            <script>
               $("#btn31").click(function(){
                  $("#postsByUsers").html(document.getElementById("printByUserOrderNewest").innerHTML);
               });
               $("#btn32").click(function(){
                  $("#postsByUsers").html(document.getElementById("printByUserOrderTop").innerHTML);
               });
                 
            </script>
            <button class="btn"id="btn31">Newest</button>
            <button class = "btn"id="btn32">Top</button>
            <div id="postsByUsers" align="center"></div>
            <div hidden id="printByUserOrderNewest" align="center">
               <c:forEach var="post" items="${sessionScope.usersByDate}">
                  <div class="postlook" align="center">
                     <div >
                        <img class="img-circle-users" src="image/ <c:url value="${post.author.username}"/>">
                        <font style= "oblique" size="5" style="color:black;">
                           <a href = "user/<c:url value="${post.author.username}"/>" >${ post.author.username }</a> posted on ${post.date} <br>
                        </font>
                        <a class="lead" style="color:blue" href = "post/
                        <c:url value="${post.postId}"/>" >${ post.postName }</a> <br><br>
                        <img src="picture/${post.postId}" height="300" >
                        <h5>${ post.likes } likes</h5>
                     </div>
                  </div>
               </c:forEach>
            </div>
            <div hidden id="printByUserOrderTop" align="center">
               <c:forEach var="post" items="${sessionScope.usersByLikes}">
                  <div class="postlook" align="center">
                     <div >
                        <img class="img-circle-users" src="image/<c:url value="${post.author.username}"/>">
                        <font style= "oblique" size="5" style="color:black;">
                           <a href = "user/<c:url value="${post.author.username}"/>" >${ post.author.username }</a> posted on ${post.date} <br>
                        </font>
                        <a class="lead" style="color:blue" href = "post/ <c:url value="${post.postId}"/>" >${ post.postName }</a> <br><br>
                        <img src="picture/${post.postId}" height="300" >
                        <h5>${ post.likes } likes</h5>
                     </div>
                  </div>
               </c:forEach>
            </div>
         </div>
         <div hidden id="printByUser" align="center">
            <h1 class = "lead">
               Users: 
               <c:out value="${sessionScope.searchFor}"></c:out>
           
            <c:if test="${sessionScope.resultsByUser==null || sessionScope.resultsByUser.isEmpty()}">
               <br><br>
               No users found
            </c:if>
            </h1>
            <c:forEach var="user" items="${sessionScope.resultsByUser}">
               <div class="postlook" align="center">
                  <!-- show small Picture -->
                  <img class="img-circle-users" src="image/<c:url value="${user.username}"/>">
                  <!-- linka kym profile page na user-a nqmam ideq dali trqbva da e taka -->
                  <a href = "/MyTravelerProject/user/<c:url value="${user.username}"/>" >${ user.username }</a><br>
                  <c:out value="${ user.first_name }"></c:out>
                  <c:out value="${ user.last_name }"></c:out> <br>
                  <c:out value="${ user.email }"></c:out>
               </div>
               <br>
            </c:forEach>
         </div>
      </header>
   </body>
</html>