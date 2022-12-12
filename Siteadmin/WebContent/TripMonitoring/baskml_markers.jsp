<%@ include file="headerhtml.jsp"%>
 
 <%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader ("Expires", 0);
%>
<%! 
Connection conn;
%>
<%


Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st = conn.createStatement();
Statement st1 = conn.createStatement();
%>
<script type="text/javascript">


</script>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<!-- you can use tables or divs for the overall layout -->
<table border="1" bgcolor="white" align="center">
<tr>
<td colspan="2">

</td>
</tr>
<tr>
<td width="20%" valign="top">
<table width="100%" border="1" valign="topo">
<tr><th colspan="1">All Loacations</th></tr>

</table>
           <!-- =========== side_bar with scroll bar ================= -->
 
<div id="side_bar"  style="overflow:auto; height:540px;" align="left" ></div>
           <!-- ===================================================== -->	
	
</td>
<td  valign="top">
       <div id="map" style="width: 800px; height: 550px"></div>
</td>
      </tr>  
</table>
    <noscript><b>JavaScript must be enabled in order for you to use Google Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Google Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>
    <script type="text/javascript">
    //<![CDATA[
   		if (GBrowserIsCompatible()) 
 		{
	      	var side_bar_html = "<table border='1' width='100%' align='left' class='sortable'>";
	 		var side_bar_html1 = "";
	  		var gmarkers = [];
	        var htmls = [];
	 	    var i = 0;
	 	    var lastvehcode=200;	
	 		var days = 0;
	 		var difference = 0;
	 		var markertoshow=[];
	 		var j = 0;
	 		var lableshow=[];
	 		var k=0;
	 		var lineshow=[];
	 		var l=0;
	 		var degreesPerRadian = 180.0 / Math.PI;
 	      	var arrowIcon = new GIcon();
 	        arrowIcon.iconSize = new GSize(12,12);
 	        arrowIcon.shadowSize = new GSize(1,1);
 	        arrowIcon.iconAnchor = new GPoint(6,6);
 	        arrowIcon.infoWindowAnchor = new GPoint(0,0);
 	      	var map = new GMap2(document.getElementById("map"));

 	      	var geoXml = new GGeoXml("http://myfleetview.com/siteadmin/KMLFiles/ALLbaseKMLFORCASTROLROUTES.kml"); 
			map.addOverlay(geoXml); 
			
 			map.addControl(new GMapTypeControl(1));
 			map.enableScrollWheelZoom();
 			map.addControl(new GSmallMapControl());
 			map.addControl(new GScaleControl());
 	     	map.setCenter(new GLatLng(18.80,80.1),5);
 	     	
 	     	function myclick(i,lat, lon) 
 	     	{
 	     		map.setCenter(new GLatLng(lat,lon));
       	        gmarkers[i].openInfoWindowHtml(htmls[i]);
 	     	}
 	     	
	      	function createMarker(point,name,html1,lat,lon) 
	      	{
			    var cIcon = new GIcon();
				cIcon.image = '../images/bp.png';
				cIcon.shadow = '../images/mm_20_shadow.png';
				cIcon.iconSize = new GSize(12,20);
				cIcon.shadowSize = new GSize(22, 20);
				cIcon.iconAnchor = new GPoint(6, 20);
				cIcon.infoWindowAnchor = new GPoint(5, 1);
				markerOptions = { icon:cIcon};
				var marker = new GMarker(point,markerOptions);
		        GEvent.addListener(marker, "click", function() { 
				map.setCenter(new GLatLng(lat,lon),9);
		        marker.openInfoWindowHtml(html1);
		      }); 
		      	/*GEvent.addListener(marker, "mouseover", function() { 
				map.setCenter(new GLatLng(lat,lon),9);
		        marker.openInfoWindowHtml(html1);
		        }); */
		     	gmarkers[i] = marker;
		      htmls[i] = html1;
		       
		       side_bar_html += '<tr><td style="text-align: left;"><a href="javascript:myclick(' + i + ','+lat+','+lon+')"  onMouseOver="javascript:myclick(' + i + ','+lat+','+lon+')"  title="">'+name+'</a><br></td></tr>';
		    	//combo +='<option value="+i+" onClick="javascript:myclick(' + i + ','+lat+','+lon+')" >'+name+'</option>';
		    	i++;
		        return marker;
		      }
<%
try
{
	String wareHouseCode="-",wareHouse="-",owner="-",html1=null;
	String sql=null;
	double lat=0.00,lon=0.00;
	sql="select WareHouseCode,WareHouse,Owner,Latitude,Longitude from t_warehousedata where Owner like 'Castrol'";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		wareHouseCode=rst.getString("WareHouseCode");
		wareHouse=rst.getString("WareHouse");
		owner=rst.getString("Owner");
		lat=rst.getDouble("Latitude");
		lon=rst.getDouble("Longitude");
		html1="<b>GeoFence</b><br>wareHouse-"+wareHouse+" owner-"+owner;
%>
 		var point = new GLatLng(<%= lat%>,<%= lon%>);
		var marker = createMarker(point,"<%=wareHouse%>","<div class='bodyText'><%=html1%></div>",<%= lat%>,<%= lon%>);
		map.addOverlay(marker);
		
<%
	} 
	%>
	side_bar_html +="</table>";
	document.getElementById("side_bar").innerHTML = side_bar_html;
	<%//end of if
}catch(Exception ex)
{
	%> alert("Exception --><%=ex%>"); <%
}
finally
{
	conn.close();
}
%>
 		}
     //]]>
    </script>

			
<%@ include file="footerhtml.jsp" %>
