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
        <br>
        <header id="head3">
            <div class="container">
                <div class="row">
                    <c:if test="${sessionScope.logged ==null }">
                        <h2 class="lead"> Please register <br> a new account</h2>
                        <h5 id = "error">${ errorMsg}</h5>
                        <form action="register" method="post">
                            <div>
                                <p> <font size="4" face="verdana" color="black" > Username: <input id="input2" type="text" value="${ username }" name="username" required></br>
                                    Email: <input id="input2" type="text"  value="${ email }" name="email" required></br>
                                    First Name: <input id="input2" type="text" value="${ firstname }" name="firstname" required></br>
                                    Family Name: <input id="input2" type="text" value="${ lastname }" name="lastname" required></br>
                                    Password: <input id="input2" type="password" placeholder="enter password" name="password" required></br>
                                    </font>
                                </p>
                            </div>
                            <input class="btn" type="submit" value = "Register"></br>
                        </form>
                    </c:if>
                    <c:if test="${sessionScope.logged != null }">
                        <jsp:forward page="updateInfo.jsp"></jsp:forward>
                    </c:if>
                    <a href="login"><font size="4" face="verdana" color="black" >Already a registered user? Login here.</font></a>
                </div>
            </div>
        </header>
    </body>
</html>