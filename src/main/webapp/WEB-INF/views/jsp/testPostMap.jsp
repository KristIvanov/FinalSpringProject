<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
         /* Always set the map height explicitly to define the size of the div
         * element that contains the map. */
         #map {
         height: 50%;
         width:80%;
         }
         /* Optional: Makes the sample page fill the window. */
         html, body {
         height: 100%;
         margin: 0;
         padding: 0;
         }
      </style>
</head>
<body>
<div id="map"></div>
<input id="longitude" hidden type="text" value="-11" name="longitude" required>
<input id="latitude" hidden type="text" value="22" name="latitude" required>

<script type="text/javascript">
	function initAutocomplete() {
		var lat = parseFloat(document.getElementById("latitude").value);
	    var lng = parseFloat(document.getElementById("longitude").value);
	    var latLng = new google.maps.LatLng(lat, lng);
	    var map = new google.maps.Map(document.getElementById('map'), {
	      center: latLng,
	      zoom: 10
	    });
	    var marker;
        var infoWindow = new google.maps.InfoWindow;
        var lat = parseFloat(document.getElementById("latitude").value);
        var lng = parseFloat(document.getElementById("longitude").value);
        alert(document.getElementById("latitude").value);
        alert(document.getElementById("longitude").value);
        
        var latLng = new google.maps.LatLng(lat, lng);
        var marker = new google.maps.Marker({
            map: map,
            position: latLng
        });
        marker.setMap(map);

	
	      
    }
</script>
<script>
         // This example adds a search box to a map, using the Google Place Autocomplete
         // feature. People can enter geographical searches. The search box will return a
         // pick list containing a mix of places and predicted search terms.
         
         // This example requires the Places library. Include the libraries=places
         // parameter when you first load the API. For example:
         // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">
         
         function auto_grow(element) {
         element.style.height = "5px";
         element.style.height = (element.scrollHeight)+"px";
         }
         
         
      </script>
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBN0sPhqPEf8YKqPYO862QcMihJmO0xb5s&callback=initMap">
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBN0sPhqPEf8YKqPYO862QcMihJmO0xb5s&libraries=places&callback=initAutocomplete"
         async defer></script>
</body>
</html>