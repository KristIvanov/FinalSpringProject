<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page errorPage="errorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <title>Logging in</title>
   </head>
   <body>
      <jsp:include page="header2.jsp" />
      <header id="head2">
         <div class="container">
            <div class="row">
               <c:if test="${sessionScope.logged ==null }">
                  <h1 class="lead">Please login</h1>
                  <font face="Bradley Hand ITC" size="4" style="color:black;">${ errorMsg}</font>
                  <form action="login" method="post">
                     <div>
                        <h4 style="color:black;"> Username: <input id="input2" type="text" placeholder="enter username" name="username" required="required"></h4>
                        <h4 style="color:black;">Password: <input id="input2" type="password" placeholder="enter password" name="password" required="required"></h4>
                        </br>
                     </div>
                     <a href="forgotPassword"> <font size="3" face="verdana" > Forgot password? </font></a>
                     <input class="btn"type="submit" value = "Login"></br>
                  </form>
                  <a href="register"> <font size="3" face="verdana" > Don`t have an account? Register here. </font></a><br>
               </c:if>
               <c:if test="${sessionScope.logged != null }">
                  <jsp:forward page="updateInfo.jsp"></jsp:forward>
               </c:if>
            </div>
         </div>
      </header>
   </body>
</html>