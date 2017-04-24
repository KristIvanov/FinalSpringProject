<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <title>Update profile</title>
   </head>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
   <script type="text/javascript">

   </script>
   <body>
      <jsp:include page="header2.jsp" />
      <header id="head4">
         <div class="container">
            <div class="row">
               <c:if test="${sessionScope.username !=null }">
                  <div class="img" >
                  <img class="img" src="/MyTravelerProject/image" align="middle" height=300 width="300"> <br>
                     <font face="Bradley Hand ITC" size="4" style="color:black;">${ errorMsg}</font>
                  <h1 class="lead">Upload Profile Picture</h1>                  
                  <form name="fileform" action="uploadPicture" method= "post" enctype="multipart/form-data" > 
                     <h4 align="center">Select new picture:  </h4>
                     <input type="file" id = "fileInput" name="picture" required/></label><br>
                     <input class="btn" type="submit" value="Upload" />           
                  </form>
                  </div>
                  <div class="settings">
                  <h1 class="lead">Update Info</h1>
                  <form  action="updateInfo" method="post">
                     Username: <input class="input" type="text" value="${ sessionScope.username }" name="newUsername"></br>
                     Email: <input class="input" type="text" value="${ sessionScope.email }" name="newEmail"></br>
                     First Name: <input class="input" type="text" value="${ sessionScope.firstname }" name="newFirstname"></br>
                     Last Name: <input class="input" type="text" value="${ sessionScope.lastname }" name="newLastname"></br>
                   	 Password: <input class="input" type="password" placeholder="enter password" name="confirmPassword" required></br>
                     <input class="btn" type="submit" value = "Update Info"></br>
                  </form>
                  </div>
                   <div class="pass">
                  <form action="changePass" method="post">
                     <h1 class="lead" >Change Password</h1>
                     Old Password: <input class="input" type="password" placeholder="enter old password" name="oldPassword" required="required"></br>
                     New Password: <input class="input" type="password" placeholder="enter new password" name="newPassword" required="required"></br>
                     <input class="btn" type="submit" value = "Change Password"></br>
                  </form>
               </c:if>
               <c:if test="${sessionScope.username ==null }">
                  <%session.setAttribute("url", "updateInfo"); %>
                  <jsp:forward page="login.jsp"></jsp:forward>
               </c:if>
            </div>
         </div>
      </header>
   </body>
</html>