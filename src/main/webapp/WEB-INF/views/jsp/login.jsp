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
						<div class="fb-login-button" data-max-rows="1" data-size="large" data-button-type="login_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="false"onlogin="checkLoginState()"></div> </form>
                  <a href="register"> <font size="3" face="verdana" > Don`t have an account? Register here. </font></a><br>
               </c:if>
               <c:if test="${sessionScope.logged != null }">
                  <jsp:forward page="updateInfo.jsp"></jsp:forward>
               </c:if>
            </div>
         </div>
      </header>
      <script>

  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));
  function checkLoginState() {
	    FB.getLoginStatus(function(response) {
	      statusChangeCallback(response);
	    });
	  }

  function statusChangeCallback(response) {
	    console.log('statusChangeCallback');
	    console.log(response);
	    // The response object is returned with a status field that lets the
	    // app know the current login status of the person.
	    // Full docs on the response object can be found in the documentation
	    // for FB.getLoginStatus().
	    if (response.status === 'connected') {
	      // Logged into your app and Facebook.
	      testAPI();
	    
	    } else {
	      // The person is not logged into your app or we are unable to tell.
	     
	    }
	  }
  
  
  window.fbAsyncInit = function() {
  FB.init({
    appId      : '1435968706467395',
    
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.9' // use graph api version 2.8
  });
  FB.AppEvents.logPageView();
  };
 
  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
	  FB.api('/me', {
			fields : 'first_name,last_name,email'
		}, function(response) {
      console.log('Successful login for: ' + response.first_name);
      $.post("fblogin", {
  		'first_name' : response.first_name,
  		'last_name' : response.last_name,
  		'email' : response.email,
      }, function(result) {
    	  window.location.href = "updateInfo";
  	});
     
    });
  
  }
</script>
   </body>
</html>