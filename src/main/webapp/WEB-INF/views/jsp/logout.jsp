<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ page errorPage="errorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logging out</title>
</head>
<body>  
<jsp:include page="header2.jsp" />
   
        <br><br><br><br><br><br><br><br>
<br>
<c:if test="${sessionScope.username !=null }">
Are you sure you want to log out?
<form action="logout" method = "post"> <input type = "submit" value= "Log out" > </form>
<a href = "index">Return to main page</a>
</c:if>
<c:if test="${sessionScope.username ==null }">
<c:redirect url= "login"></c:redirect>
</c:if>

</body>
</html>