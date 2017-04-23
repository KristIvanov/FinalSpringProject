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
   
<header id="head2">
         <div class="container">
            <div class="row">
<c:if test="${sessionScope.username !=null }">
<h2 class="lead">Are you sure you want to log out? </h2>
<form action="logout" method = "post"> 
<input class="btn" type = "submit" value= "Log out" > </form>
<a href = "indexx"><font size="3" face="verdana" >Return to main page</font></a>
</c:if>
<c:if test="${sessionScope.username ==null }">
<c:redirect url= "login"></c:redirect>
</c:if>
</div>
         </div>
      </header>
</body>
</html>