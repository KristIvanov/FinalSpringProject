<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page errorPage="errorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <title>Contact us</title>
   </head>
   <body>
      <jsp:include page="header2.jsp" />
      <header id="head9">
         <div class="container">
         <div class="row">
            <h3 class="lead">Share your opinion with us: </h3>
            <font face="Bradley Hand ITC" size="4" style="color:black;">${ errorMsg}</font>
            <form action="contactUs" method="post" >
               <div>
                  <div>
                     <h3 style="color:grey;"> Email: <br> <input id="input3" type="email" name="email" placeholder="Enter your email"  required></br></h3>
                     <h3 style="color:grey;">Message: <br><textarea id="input3" onkeyup="auto_grow(this)" name="message" placeholder="Enter your message"  required></textarea></h3>
                  </div>
                  <input class="btn" type="submit" value = "Send message"></br>
            </form>
            <a href = "indexx"><font color="black"size="3" face="verdana" >Return to main page</font></a>
            <c:if test="${sessionScope.username ==null }">
            <c:redirect url= "login"></c:redirect>
            </c:if>
            </div>
         </div>
      </header>
   </body>
</html>