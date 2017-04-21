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
z
	function uploadPicture()
	{ 
		 var fd = new FormData(document.getElementById("fileform"));
		 fd.append("picture", document.getElementById("fileInput").files[0]);
         var fileExtension = document.getElementById("fileInput").value.split('.').pop().toLowerCase();
         fd.append("extension", fileExtension);
		$.ajax({
			  url: "uploadPicture",
			  type: "POST",
			  data: fd,
			  processData: false,
			  contentType: false,
			  function(result){
	       			document.getElementById("response").innerHTML = result;
	       			$("#picture").attr("src", "${profilePic}");
			  }
		});
	}
	</script>
<body>
<jsp:include page="header.jsp" />
<br>
<br>
<c:if test="${sessionScope.username !=null }">
<h5 id = "error">${ errorMsg}</h5>
<img id="picture" src="/MyTravelerProject/image" height=300 width="300">
<h1>Upload Profile Picture</h1>
        <form name="fileform" id=" fileForm" enctype="multipart/form-data" onsubmit="return uploadPicture()"> 
            <label for="photo"> Select picture :  </label>
            <input type="file" id = "fileInput" name="picture" size="50" placeholder="Upload Your Image" required/><br><br>
 			<input type="submit" value="Upload" />           
  </form>
        <h5 id="response"></h5>
<h1>Update Info</h1>
<form action="updateInfo" method="post">
Username: <input type="text" value="${ sessionScope.username }" name="newUsername"></br>
Email: <input type="text" value="${ sessionScope.email }" name="newEmail"></br>
First Name: <input type="text" value="${ sessionScope.firstname }" name="newFirstname"></br>
Last Name: <input type="text" value="${ sessionScope.lastname }" name="newLastname"></br>
Confirm Password: <input type="password" placeholder="enter password" name="confirmPassword"></br>
<input type="submit" value = "Update Info"></br>
</form>
<h5 id = "error">${ errorMsg}</h5>
<form action="changePass" method="post">
<h1>Change Password</h1>
Old Password: <input type="password" placeholder="enter old password" name="oldPassword" required="required"></br>
New Password: <input type="password" placeholder="enter new password" name="newPassword" required="required"></br>
<input type="submit" value = "Change Password"></br>
</form>
</c:if>
<c:if test="${sessionScope.username ==null }">
<%session.setAttribute("url", "updateInfo"); %>
<jsp:forward page="login"></jsp:forward>
</c:if>
</body>
</html>