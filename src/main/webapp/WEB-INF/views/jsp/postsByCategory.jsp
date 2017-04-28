<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page errorPage="errorPage.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <title>Posts in category ${category}:</title>
   </head>
      
      
   <body>
      <jsp:include page="header2.jsp" />
      <header id="head4">
         <div class="container">
            <div class="row">
            <h1 class="lead"> Posts in category ${category}: </h1> <br>
               <c:if test="${posts != null}">
                  <c:forEach var="post" items="${posts}">
                     <div >
                        <img class="img-circle-users" src="image/<c:url value="${post.author.username}"/>">
                        <font style= "oblique" size="5" style="color:black;">
                           <a href = "user/<c:url value="${post.author.username}"/>" >${ post.author.username }</a> posted on ${post.date} <br>
                        </font>
                        <a class="lead" style="color:blue" href = "post/<c:url value="${post.postId}"/> " >${ post.postName }</a> <br><br>
                        <img src="picture/${post.postId}" height="300" >
                        <h5>${ post.likes } likes</h5>
                  
                     </div>
                     <br>
                  </c:forEach>
               </c:if>
               <c:if test="${posts == null}"> 
                <h1 class="lead"> No posts in this category! </h1> <br>
                <a class="btn btn-action btn-lg" href="/MyTravelerProject/addPost" >Add new post!</a></p>
                  </c:if>
            </div>
         </div>
      </header>
     
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
      <script src="https://code.jquery.com/jquery-1.7.1.js" type="text/javascript"></script>
   </body>
</html>