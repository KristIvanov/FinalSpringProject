<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
  <jsp:include page="header2.jsp" />
      <header id="head4">
         <div class="container">
            <div class="row">
               <c:if test="${sessionScope.username !=null }">
             	  <c:if test="${posts.size > 0}"></c:if>
               		<c:forEach var="post" items="${posts}">
               		<a href = "user/<c:url value="${post.author.name}"/>" >${ post.author.name }</a> posted on ${post.date} <br>
               		<h3>${post.name}</h3>
               		<img src="${post.pictureURL}" height="100" weight="100">
                	</c:forEach>
                	</c:if>
               
                <c:if test="${sessionScope.username ==null }">
                  <%session.setAttribute("url", "updateInfo"); %>
                  <jsp:forward page="login.jsp"></jsp:forward>
               </c:if>
            </div>
         </div>
      </header>
</body>
</html>