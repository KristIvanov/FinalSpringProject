<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page errorPage="errorPage.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <title>Insert title here</title>
   </head>
   <style>
      .p {
      border: 2px solid grey;
      border-radius: 6px;
      max-width:100%; 
      max-height:100%;
      }
      /* The Modal (background) */
      .modal {
      display: none; /* Hidden by default */
      position: fixed; /* Stay in place */
      z-index: 1; /* Sit on top */
      padding-top: 100px; /* Location of the box */
      left: 0;
      top: 0;
      width: 100%; /* Full width */
      height: 100%; /* Full height */
      overflow: auto; /* Enable scroll if needed */
      background-color: rgb(0,0,0); /* Fallback color */
      background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
      }
      /* Modal Content */
      .modal-content {
      background-color: #fefefe;
      margin: auto;
      padding: 20px;
      border: 1px solid #888;
      width: 20%;
      }
      /* The Close Button */
      .close {
      color: #aaaaaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
      }
      .close:hover,
      .close:focus {
      color: #000;
      text-decoration: none;
      cursor: pointer;
      }
      
   </style>
   <body>
      <jsp:include page="header2.jsp" />
      <header id="head4">
         <div class="container">
            <div class="row">
               <c:if test="${posts != null}">
                  <c:forEach var="post" items="${posts}">
                     <div class="border">
                        <img class="img-circle-users" src="image/
                        <c:url value="${post.author.username}"/>
                        ">
                        <font style= "oblique" size="5" style="color:black;">
                           <a href = "user/
                           <c:url value="${post.author.username}"/>
                           " >${ post.author.username }</a> posted on ${post.date} <br>
                        </font>
                        <a class="lead" href = "post/
                        <c:url value="${post.postId}"/>
                        " >${ post.postName }</a> <br><br>
                        <img class="picture" src="${post.pictureURL}" >
                        <button id="likesBtn">${ post.likes } likes</button>
                        <div id="myModal" class="modal">
                           <!-- Modal content -->
                           <div class="modal-content">
                              <span class="close">&times;</span>
                              <c:forEach var="User" items="${post.likers}">
                                 <div class="userlook" align="center">
                                    <!-- show small Picture -->
                                    <img class="img-circle-users" src="image/
                                    <c:url value="${post.author.username}"/>
                                    ">
                                    <font style= "oblique" size="5" style="color:black;">
                                       <a href = "user/
                                       <c:url value="${post.author.username}"/>
                                       " >${ post.author.username }</a> <br>
                                    </font>
                                    <c:out value="${ user.first_name }"></c:out>
                                    <c:out value="${ user.last_name }"></c:out>
                                 </div>
                                 <br>
                              </c:forEach>
                           </div>
                        </div>
                     </div>
                     <br>
                  </c:forEach>
               </c:if>
            </div>
            <!-- The Modal -->
         </div>
      </header>
      <script>
         // Get the modal
         var modal = document.getElementById('myModal');
         
         // Get the button that opens the modal
         var btn = document.getElementById("likesBtn");
         
         // Get the <span> element that closes the modal
         var span = document.getElementsByClassName("close")[0];
         
         // When the user clicks the button, open the modal 
         btn.onclick = function() {
         	alert("test1");
             modal.style.display = "block";
         }
         
         // When the user clicks on <span> (x), close the modal
         span.onclick = function() {
             modal.style.display = "none";
         }
         
         // When the user clicks anywhere outside of the modal, close it
         window.onclick = function(event) {
             if (event.target == modal) {
                 modal.style.display = "none";
             }
         }
      </script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
      <script src="https://code.jquery.com/jquery-1.7.1.js" type="text/javascript"></script>
   </body>
</html>