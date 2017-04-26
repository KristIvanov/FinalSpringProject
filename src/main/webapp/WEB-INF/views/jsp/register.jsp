<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page errorPage="errorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Register</title>
    </head>
    <body>
        <jsp:include page="header2.jsp" />
        <header id="head3">
            <div class="container">
                <div class="row">
                    <c:if test="${sessionScope.logged ==null }">
                        <h2 class="lead"> Please register <br> a new account</h2>
                        <font face="Bradley Hand ITC" size="4" style="color:black;">${ errorMsg}</font>
                        <form action="register" method="post">
                            <div>
                                <p> <font size="4" face="Book Antiqua" color="black" > 
                                	Username (5 symbols): <input id="input2" type="text" placeholder="enter username" value="${ username }" name="username" required><br>
                                    Email: <input id="input2" type="email" placeholder="enter email" value="${ email }" name="email" required></br>
                                    First Name: <input id="input2" type="text" placeholder="enter firstname" value="${ firstname }" name="firstname" required></br>
                                    Family Name: <input id="input2" type="text" placeholder="enter lastname" value="${ lastname }" name="lastname" required></br>
                                    Password: <input id="input2" type="password" placeholder="enter password" name="password" required> 
                                    </font>
                                </p>
                                <p> <font size="2" face="verdana" color="white" >Should contain upper&lower case letter and digit. </font></p></br>
                            </div>
                            <input class="btn" type="submit" value = "Register"></br>
                        </form>
                    </c:if>
                    <c:if test="${sessionScope.logged != null }">
                        <jsp:forward page="updateInfo.jsp"></jsp:forward>
                    </c:if>
                    <a href="login"><font size="4" face="verdana" color="white" >Already a registered user? Login here.</font></a>
                </div>
            </div>
        </header>
    </body>
</html>