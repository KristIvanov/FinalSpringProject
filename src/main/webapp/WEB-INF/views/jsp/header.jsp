<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%! boolean logged;
	String button0 = "Home";
	String button1 = "Register";
	String button2 = "Log in";
	String link0 = "index";
	String link1 = "register";
	String link2 = "login";%>
	<div align = "right">
	<% if(session.getAttribute("username")!= null){
			button0 = "Home";
			button1 = "Settings";
			button2 = "Log out";
			link0 = "/MyTravelerProject/index";
			link1 = "/MyTravelerProject/settings";
			link2 = "/MyTravelerProject/logout";
		}
		else {
			button0 = "Home";
			button1 = "Register";
			button2 = "Log in";
			link0 = "/MyTravelerProject/index";
			link1 = "/MyTravelerProject/register";
			link2 = "/MyTravelerProject/login";
		}
	%>
		<a href = "<%= link0%>" ><%= button0%></a>
		<a href = "<%= link1%>" ><%= button1%></a>
		<a href = "<%= link2%>" ><%= button2%></a>
	</div>
	<jsp:include page="quickSearch.jsp" />
	<font face="Verdana" size="7">TravelBook</font><br>
	<hr>
</body>
</html>