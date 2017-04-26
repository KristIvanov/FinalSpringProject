<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ page errorPage="errorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>All users</title>
</head>
<body>
<jsp:include page="header2.jsp" />
      <header id="head4">
         <div class="container">
            <div class="row">
            <h1 class="lead"> All users:</h1> <br>
             <c:if test="${users != null}">
                  <c:forEach var="user" items="${users}">
                     <div >
                       <img class="img-circle-users" src="image/<c:url value="${user.username}"/>">
			                   <a href = "/MyTravelerProject/user/<c:url value="${user.username}"/>" >${ user.username }</a><br>
			                   <c:out value="${ user.first_name }"></c:out>
			                   <c:out value="${ user.last_name }"></c:out> <br>
			                   <c:out value="${ user.email }"></c:out>
            			</div>
                		<br>
             		</c:forEach>
             		</c:if>
             		<c:if test="${users.isEmpty()}">No users!</c:if>
             		</div>
             		</div>
             		</header>
           
</body>
</html>