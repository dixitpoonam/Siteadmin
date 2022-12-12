<%@ include file="conn.jsp" %>
<html>
<head>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>

<meta http-equiv="content-type" content="text/html; charset=UTF-8" >
<script src="elabel.js" type="text/javascript"></script>
<style type="text/css">
.elabelstyle {color:black; padding: 1px; font-size: 1.1em;}
.origelabelstyle {color:#000000; background-color:#ffffaa; border:0px #006699 solid; padding: 2px; font-size: 0.7em;}
</style>
</head>
<body onload="loadmap();">


<script type="text/javascript">
    //<![CDATA[	
   
if (GBrowserIsCompatible()) {
	function loadmap(){
	var map = new GMap2(document.getElementById("map"));
	<%!
	Statement st;
	String sql,vehcode,thedate,thetime,latitude,longitude,location;
	Connection conn;

%>
<%
vehcode=request.getParameter("vehcode");
thedate=request.getParameter("thedate");
thetime=request.getParameter("thetime");

Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try{
	st=conn.createStatement();
	sql="select * from t_veh"+vehcode+" where TheFieldDataDate='"+thedate+"' and TheFieldDataTime >='"+thetime+"' and TheFiledTextFileName='SI' order by TheFieldDataTime limit 2";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
		{
			latitude=rst.getString("LatinDec");
			longitude=rst.getString("LonginDec");
			location=rst.getString("TheFieldSubject");
		
		%>
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
	    marker.openInfoWindowHtml("<%= location%>");
        });
	map.addOverlay(marker);

<%
	}

}
catch(Exception e)
{
	out.print("Exception--->"+e);
	%>
		alert(<%=e%>);	
	<%
}finally{
	conn.close();	
}
%>
}
}

 //]]>
</script>
<table border="1">
<tr><td>
<div id=map style="width: 470px; height: 315px"></div>
</td></tr>
</table>
</body>
<%@ include file="footerhtml.jsp" %>
