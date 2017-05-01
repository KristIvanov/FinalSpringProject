<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta charset="utf-8">
      <meta name="viewport"    content="width=device-width, initial-scale=1.0">
      <meta name="description" content="">
      <title>Travelbook</title>
      <link rel="shortcut icon" href="gt_favicon.png">
      <link rel="stylesheet" media="screen" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
      <link rel="stylesheet" href="/MyTravelerProject/css/bootstrap-min.css">
      <link rel="stylesheet" href="/MyTravelerProject/css/font-awesome-min.css">
      <link rel="stylesheet" href="/MyTravelerProject/css/bootstrap-theme.css" media="screen" >
      <link rel="stylesheet" href="/MyTravelerProject/css/main.css">
       <link href="/MyTravelerProject/css/simple-sidebar.css" rel="stylesheet">
   </head>
  <style>
.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    padding: 12px 16px;
    z-index: 1;
}

.dropdown:hover .dropdown-content {
    display: block;
}
</style>
   <body>
   
   <jsp:include page="sidebar.jsp"></jsp:include>
      <!-- Fixed navbar -->
      <div class="navbar navbar-inverse navbar-fixed-top headroom" >
         <div class="container">
            <div class="navbar-header">
               <!-- Button for smallest screens -->
               <button type="button" class="navbar-toggle" data-toggle="collapse"  data-target=".navbar-collapse"><span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
               <a  href="/MyTravelerProject/indexx" ><img src="/MyTravelerProject/img/logo1.png" height="90" width="190" alt="Travelbook"></a>
            </div>
            <div class="navbar-collapse collapse">
               <ul class="nav navbar-nav pull-right">
             	 <li>
             	 	<div class="dropdown">
  						<a class="btn btn-lg " style="color:white" >Posts</a>
 							 <div class="btn dropdown-content">
   								 <a class="btn" href="/MyTravelerProject/allPosts">All</a> <br>
   								 <a class="btn" href="/MyTravelerProject/posts?category=Beaches">Beaches</a><br>
   								 <a class="btn" href="/MyTravelerProject/posts?category=Hills">Hills</a> <br>
   								 <a class="btn" href="/MyTravelerProject/posts?category=Monuments">Monuments</a><br>
   								 <a class="btn" href="/MyTravelerProject/posts?category=Museums">Museums</a><br>
   								 <a class="btn" href="/MyTravelerProject/posts?category=Wildlife">Wildlife</a> <br>
   								  <a class="btn" href="/MyTravelerProject/posts?category=Cities">Cities</a> <br>
   								 <a class="btn" href="/MyTravelerProject/posts?category=Mountains">Mountains</a> <br>
   								  <a class="btn" href="/MyTravelerProject/posts?category=Forests">Forests</a> <br>
   								 
  							</div>
					</div>
				  </li>
                  <li>
                     <form action="/MyTravelerProject/quickSearch" method="get">
                        <input id="input1" style="color:white" type="text" class="btn" placeholder="Search Travelbook" name="searchFor" required>
                        <input class="btn" type="submit" value = "Quick Search">
                     </form>
                  </li>
                  <c:if test="${sessionScope.logged==null}">
                  <li><a class="btn" href="/MyTravelerProject/login">Login</a></li>
                  <li><a class="btn" href="/MyTravelerProject/register">Register</a></li>
                
          </c:if>
                 <c:if test="${sessionScope.logged!=null}">
                  <li><a class="btn" href="/MyTravelerProject/logout">Logout</a></li>
                  <li><a class="btn" href="/MyTravelerProject/addPost">Add new post</a></li>
                  
                  </c:if>
               </ul>
            </div>
         </div>
      </div>
   


   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<script src="/MyTravelerProject/js/headroom.min.js"></script>
	<script src="/MyTravelerProject/js/jQuery-headroom-min.js"></script>
	<script src="/MyTravelerProject/js/template.js"></script>
	</body>
</html>