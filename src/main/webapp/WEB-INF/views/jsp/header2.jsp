<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta charset="utf-8">
      <meta name="viewport"    content="width=device-width, initial-scale=1.0">
      <meta name="description" content="">
      <title>Travelbook</title>
      <link rel="shortcut icon" href="gt_favicon.png">
      <link rel="stylesheet" media="screen" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
      <link rel="stylesheet" href="css/bootstrap-min.css">
      <link rel="stylesheet" href="css/font-awesome-min.css">
      <link rel="stylesheet" href="css/bootstrap-theme.css" media="screen" >
      <link rel="stylesheet" href="css/main.css">
   </head>
  
   <body>
      <!-- Fixed navbar -->
      <div class="navbar navbar-inverse navbar-fixed-top headroom" >
         <div class="container">
            <div class="navbar-header">
               <!-- Button for smallest screens -->
               <button type="button" class="navbar-toggle" data-toggle="collapse"  data-target=".navbar-collapse"><span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
               <a  href="indexx" ><img src="img/logo1.png" height="100" width="190" alt="Travelbook"></a>
            </div>
            <div class="navbar-collapse collapse">
               <ul class="nav navbar-nav pull-right">
                  <li>
                     <form action="/MyTravelerProject/quickSearch" method="get">
                        <input id="input" type="text" class="btn" placeholder="Search Travelbook" name="searchFor" required>
                        <input class="btn" type="submit" value = "Quick Search">
                     </form>
                  </li>
                  <%if(request.getSession().getAttribute("logged") == null){ %>
                  <li><a class="btn" href="/MyTravelerProject/login">Login</a></li>
                  <li><a class="btn" href="/MyTravelerProject/register">Register</a></li>
                  <%}else{ %>
                  <li><a class="btn" href="/MyTravelerProject/LogoutServlet">Logout</a></li>
                  <li><a class="btn" href="/MyTravelerProject/profile">Settings</a></li>
                  <li><a class="btn" href="/MyTravelerProject/addPost">Add new post</a></li>
                  <%} %>
               </ul>
            </div>
            <!--/.nav-collapse -->
         </div>
      </div>
   </body>
</html>