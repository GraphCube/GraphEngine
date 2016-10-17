<!doctype html>
<html>
<head>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB8ddDFXu6a0dzQDv8M_qwl9uFovvMZqsk"
      type="text/javascript"></script>
<meta charset="utf-8">
<title>Map</title>
</head>

<body onLoad="loadScript()">
<cfparam name="URL.LAT" default="-34.397">
<cfparam name="URL.LON" default="150.644">
<cfparam name="URL.Zoom" default="11">
<cfparam name="URL.Type" default="TERRAIN">


<script type="text/javascript">
 function initialize() {
  var mapOptions = {
  <cfoutput>zoom: #URL.zoom#,
    center: new google.maps.LatLng(#URL.LAT#, #URL.LON#),
    mapTypeId: google.maps.MapTypeId.#URL.Type#</cfoutput>
  }
  var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
  var marker = new google.maps.Marker({
    position: <cfoutput>{lat: #URL.LAT#, lng: #URL.LON#}</cfoutput>,
    map: map,
    title: <cfoutput>'Drone Srtike: #DateFormat(URL.dsDate,"dddd dd mmmm yyyy")#'</cfoutput>
  });
}
function loadScript() {
  var script = document.createElement("script");
  script.type = "text/javascript";
  script.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyB8ddDFXu6a0dzQDv8M_qwl9uFovvMZqsk&callback=initialize";
  document.body.appendChild(script);
}
 </script>	  
 
 <cfoutput>
 <div id="map_canvas" style="width:100%;height:260px;"></div>
 </cfoutput>
</body>
</html>