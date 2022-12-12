<%@ include file="conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">


<head>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<script src="elabel.js" type="text/javascript"></script>
<style type="text/css">
.elabelstyle {color:black; padding: 1px; font-size: 1.1em;}
.origelabelstyle {color:#000000; background-color:#ffffaa; border:0px #006699 solid; padding: 2px; font-size: 0.7em;}
</style>
<body onload="loadmap();">
<script type="text/javascript">
    //<![CDATA[	
if (GBrowserIsCompatible()) {
<%!
String latitude,longitude,discription;
%>
<%

//Statement s = conn.createStatement();
//Statement s2 = conn.createStatement();
//Statement s3 = conn.createStatement();


discription=request.getParameter("discription");
latitude=request.getParameter("lat");
longitude=request.getParameter("long");
%>


   function loadmap(){
        var map = new GMap2(document.getElementById("map"));
	map.setCenter(new GLatLng(<%=latitude%>,<%=longitude %>),9);
	map.addControl(new GMapTypeControl(1));
	map.enableScrollWheelZoom();
	map.addControl(new GSmallMapControl());
	map.addControl(new GScaleControl());
	     
      	var cIcon = new GIcon();
cIcon.image = '../images/t5.png';
	cIcon.shadow = '../images/mm_20_shadow.png';
	cIcon.iconSize = new GSize(12,20);
	cIcon.shadowSize = new GSize(10, 10);
	cIcon.iconAnchor = new GPoint(16,11);
	cIcon.infoWindowAnchor = new GPoint(5, 1);
	markerOptions = { icon:cIcon};
	var point = new GLatLng(<%=latitude%>,<%=longitude %>);
	var marker = new GMarker(point, markerOptions);
	 GEvent.addListener(marker, "mouseover", function() {
	    marker.openInfoWindowHtml("<%= discription%>");
        });
	map.addOverlay(marker);
}
}


 //]]>
</script>
<table border="1">
<tr><td>
<div id=map style="width: 470px; height: 470px"></div>
</td></tr>
</table>
</body>
</html>
