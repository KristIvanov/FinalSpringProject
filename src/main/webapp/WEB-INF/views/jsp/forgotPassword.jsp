<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <title>Forgot password</title>
   </head>
   <body>
      <jsp:include page="header2.jsp" />
      <header id="head5">
         <div class="container">
            <div class="row">
               <c:if test="${sessionScope.logged ==null }">
                  <h1 class="lead">Enter your username <br> and password</h1>
                  <h5 style="color:black; id = "error">${ errorMsg}</h5>
                  <form action="forgotPassword" method = "POST">
                     <div>
                        <h4 style="color:black;"> Username: <input id="input2" type="text" placeholder="enter username" name="username" required="required"></h4>
                        <h4 style="color:black;">&nbsp &nbsp &nbsp &nbsp Email: <input id="input2" type="email" placeholder="enter email" name="email" required="required"></h4>
                     </div>
                     <input class="btn"type="submit" value = "Submit"></br>
                  </form>
               </c:if>
               <c:if test="${sessionScope.logged != null }">
                  <jsp:forward page="updateInfo.jsp"></jsp:forward>
               </c:if>
            </div>
         </div>
      </header>
   </body>
</html>