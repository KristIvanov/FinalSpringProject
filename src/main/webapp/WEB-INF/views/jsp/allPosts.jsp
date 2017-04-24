<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
.p {
    border: 2px solid grey;
    border-radius: 6px;
    max-width:100%; 
  max-height:100%;
}
</style>
<body>
  <jsp:include page="header2.jsp" />
      <header id="head4">
         <div class="container">
            <div class="row">
             	  <c:if test="${posts != null}"></c:if>
               		<c:forEach var="post" items="${posts}">
               		<div class="border">
               		 <img class="img-circle-users" src="image/<c:url value="${post.author.username}"/>">
               		<font style= "oblique" size="5" style="color:black;"><a href = "user/<c:url value="${post.author.username}"/>" >${ post.author.username }</a> posted on ${post.date} <br>
               		</font><a class="lead" href = "post/<c:url value="${post.postId}"/>" >${ post.postName }</a> <br><br>
               		<img class="p"src="${post.pictureURL}" height="300" width="700">
               		                     <h4 align="center">${post.likes} people like this! </h4>
               		
               		</div>
               		<br>
                	</c:forEach>
               </div>
                
            </div>
      </header>
</body>
</html>