<%@ include file="conn.jsp" %>
<html>
<head>
 <script language="javascript" type="text/javascript">
 

function ajaxFunction(lon,lat)
 {
	 var lon=document.getElementById("lon").value;
	 var lat=document.getElementById("lat").value;
	 //alert(lon);
	// alert(lat);
   
     // The variable that makes Ajax possible!
   var ajaxRequest;
   try{
 		// Opera 8.0+, Firefox, Safari
 		ajaxRequest = new XMLHttpRequest();
 	  }
	  catch (e)
	  {
 		  // Internet Explorer Browsers
 		 try
           {
 			   ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
 		    } 
         catch (e)
                 {
 			   try
                    {
 			       ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
 			        } 
                catch (e)
                     {
 			    	  // Something went wrong
 			      		alert("Your browser broke!");
 			      		return false;
 			   		  }
 		        }
        }

          // Create a function that will receive data sent from the server
       	  ajaxRequest.onreadystatechange = function()
            {
     	 	  if(ajaxRequest.readyState == 4)
               {
                //  alert("IN side ==4");
     	 		   var reslt=ajaxRequest.responseText;
     	 		   //alert(mySplitResult);
              	   var mySplitResult = reslt.split("$#");
                   document.waypointform.warehouse.value=mySplitResult[0];
                   document.waypointform.geocode.value=mySplitResult[1];
                   alert(document.waypointform.warehouse.value);
                   alert(document.waypointform.geocode.value);
        	      } 
          	  }
             var queryString = "?lat="+lat+"&lon="+lon;
 	     ajaxRequest.open("GET", "AjaxGetGeoFence.jsp" + queryString, true);
 	     ajaxRequest.send(null); 


 }

</script>
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
   

		  

		
   
if (GBrowserIsCompatible()) 
{
	function loadmap()
	{
		var degreesPerRadian = 180.0 / Math.PI;
      	var arrowIcon = new GIcon();
        arrowIcon.iconSize = new GSize(12,12);
        arrowIcon.shadowSize = new GSize(1,1);
        arrowIcon.iconAnchor = new GPoint(6,6);
        arrowIcon.infoWindowAnchor = new GPoint(0,0);

      var side_bar_html = "";
      var side_bar_html1 = "";
      var str;	
      var gmarkers = [];
      var htmls = [];
      var i = 0;
	
	var map = new GMap2(document.getElementById("map"));
	map.addControl(new GMapTypeControl(1));
	map.enableScrollWheelZoom();
	map.addControl(new GSmallMapControl());
	map.addControl(new GScaleControl());



	
	function createMarker1(point,name,html,lat,lon)
	{
		 	var cIcon = new GIcon();
			cIcon.image = '../images/mm_20_red.png';
			cIcon.shadow = '../images/mm_20_shadow.png';
			cIcon.iconSize = new GSize(12,20);
			cIcon.shadowSize = new GSize(10, 10);
			cIcon.iconAnchor = new GPoint(16,11);
			cIcon.infoWindowAnchor = new GPoint(5, 1);
			markerOptions = { icon:cIcon};

			var marker = new GMarker(point, markerOptions);
			//var marker = new GMarker(point);
	        GEvent.addListener(marker, "click", function() {
			map.setCenter(new GLatLng(lat,lon),9);
	        marker.openInfoWindowHtml(html1);
	        });
	      	GEvent.addListener(marker, "mouseover", function() {
			//map.setCenter(new GLatLng(lat,lon),9);
	        marker.openInfoWindowHtml(html);
	        });
	      	gmarkers[i] = marker;
	        htmls[i] = html;
	        side_bar_html += '<div class="bodyText">' + name + '</div></a><br>';
	        i++;
			return marker;
	}

	function createMarker2(point,name,html,lat,lon)
	{
		 	var cIcon1 = new GIcon();
			cIcon1.image = '../images/mm_20_blue.png';
			cIcon1.shadow = '../images/mm_20_shadow.png';
			cIcon1.iconSize = new GSize(12,20);
			cIcon1.shadowSize = new GSize(10, 10);
			cIcon1.iconAnchor = new GPoint(16,11);
			cIcon1.infoWindowAnchor = new GPoint(5,1);
			markerOptions = { icon:cIcon1};

			var marker1 = new GMarker(point, markerOptions);
			//var marker = new GMarker(point);
	        GEvent.addListener(marker1, "click", function() {
			map.setCenter(new GLatLng(lat,lon),9);
	        marker1.openInfoWindowHtml(html);
	        });
	      	GEvent.addListener(marker1, "mouseover", function() {
			//map.setCenter(new GLatLng(lat,lon),9);
	        marker1.openInfoWindowHtml(html);
	        });
	      	gmarkers[i] = marker1;
	        htmls[i] = html;
	        side_bar_html += '<div class="bodyText">' + name + '</div></a><hr><br>';
	        i++;
			return marker1;
	}

	function createMarker3(point,name,html,lat,lon)
	{
		 	var cIcon3 = new GIcon();
			cIcon3.image = '../images/mm_20_black.png';
			cIcon3.shadow = '../images/mm_20_shadow.png';
			cIcon3.iconSize = new GSize(12,20);
			cIcon3.shadowSize = new GSize(10, 10);
			cIcon3.iconAnchor = new GPoint(16,11);
			cIcon3.infoWindowAnchor = new GPoint(5,1);
			markerOptions = { icon:cIcon3};

			var marker3 = new GMarker(point, markerOptions);
			//var marker = new GMarker(point);
	        GEvent.addListener(marker3, "click", function() {
			map.setCenter(new GLatLng(lat,lon),9);
	        marker3.openInfoWindowHtml(html);
	        });
	      	GEvent.addListener(marker3, "mouseover", function() {
			//map.setCenter(new GLatLng(lat,lon),9);
	        marker3.openInfoWindowHtml(html);
	        });
	      	gmarkers[i] = marker3;
	        htmls[i] = html;
	        side_bar_html += '<div class="bodyText">' + name + '</div></a><br>';
	        i++;
			return marker3;

			
	}
	 //<![CDATA[

  	var map = new GMap2(document.getElementById("map"));
        map.setCenter(new GLatLng(18.80,80.1),5);
	map.addControl(new GMapTypeControl(1));
	map.enableScrollWheelZoom();
	map.addControl(new GSmallMapControl());
	map.addControl(new GScaleControl());

	lstner = GEvent.addListener(map, 'click', function(overlay, point){
	document.waypointform.lat.value=point.x;
	document.waypointform.lon.value=point.y;
	ajaxFunction(point.x,point.y);
   	});

//]]>
	

	
	<%!
	Statement st,st1,stmtoday;
	String sql,sql1,vehcode,vehregno,thedate,thetime,tripid,latitude,longitude,location,latitude1,longitude1,location1,startdatetime;
	String lat,lon,lat1,lon1,lastlocation,colorcode,endlat,endlong,endLocation,startcode,startlocation,endcode,thedateformat100;
	String thetime100,location100;
	java.util.Date thedate100=null;
	java.util.Date today=new java.util.Date();
	int dist,dist1;
	double endLat,endLon,Lat,Lon;
	String lat3,lon3,thetime3,location3,transporter;
	java.util.Date thedate3=null;
	Connection conn;
%>
<%
startcode=request.getParameter("startcode");
startlocation=request.getParameter("startlocation");
endcode=request.getParameter("endcode");
endlat=request.getParameter("endlat");
endlong=request.getParameter("endlon");
endLat=Double.valueOf(endlat);
endLon=Double.valueOf(endlong);
//System.out.println("EndLat::>>"+endLat);
//System.out.println("EndLon::>>"+endLon);
//System.out.println("EndLat After Increment::>>"+(endLat+0.0001));
//System.out.println("EndLon After Increment::>>"+(endLon+0.0001));
endLat=endLat+0.0001;
endLon=endLon+0.0001;
vehcode=request.getParameter("vehcode");
thedate=request.getParameter("startdate");
thetime=request.getParameter("startTime");
vehregno=request.getParameter("vehregno");
endLocation=request.getParameter("endLocation");
tripid=request.getParameter("tripid");
transporter=request.getParameter("transporter");
System.out.println("tripid::>>>"+tripid);
System.out.println("Transporter::>>>"+transporter);
startdatetime=thedate+" "+thetime;

//System.out.println("Startdatetime::>>>"+startdatetime);
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	stmtoday=conn.createStatement();
	
		%>
		
		
  
		



		

<%
	
	//System.out.println("Hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii::>>>");

	//System.out.println("Date::>>>"+thedate+" "+thetime);
	//***************************Polyline code**************************
		String sql10 = "SELECT LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehcode+" where concat(TheFieldDataDate,TheFieldDataTime)>='"+ thedate+thetime+"' and LatinDec>0 order by TheFieldDataDate Asc,TheFieldDataTime Asc limit 1";
		ResultSet rs10 = st.executeQuery(sql10);
		while(rs10.next())
		{
			lat = rs10.getString("lat1"); 
			lon = rs10.getString("lon1");
			
			thedate100= rs10.getDate("TheFieldDataDate");
			thetime100 = rs10.getString("TheFieldDataTime");
			long tdate = thedate100.getTime();
			location100= rs10.getString("TheFieldSubject");
			thedateformat100=new SimpleDateFormat("dd-MMM-yyyy").format(thedate100);
		}
		%>

		side_bar_html +='<font size="2" face="arial" color="red" ><b>Vehicle        :</b></font> <font size="2" face="arial" color="#B22222" ><b><%= vehregno%> </b></font><br>';
		side_bar_html +='<font size="2" face="arial" color="red" ><b>Transporter         :</b></font><font size="2" face="arial" color="#B22222" ><b><%= transporter%></b></font><br>';
		side_bar_html +='<font size="2" face="arial" color="red" ><b>Trip ID         :</b></font><font size="2" face="arial" color="#B22222" ><b> <%= tripid%> </b></font><br><hr/>';
		
		
		var point1 = new GLatLng(<%=lat%>,<%= lon%>);
		map.setCenter(point1,9);
		
		var marker = createMarker1(point1,"<div class='bodyText'><font size='2' face='arial'><b>Start Location</b>  <%= thedateformat100%> <%= thetime100%> <%= startlocation%></font></div>","<div class='bodyText'><%= vehregno%><br><%= thedateformat100%> <%= thetime100%><br> <%= location100%><br><%=startcode%></div>",<%= lat%>,<%= lon%>);
		
		map.addOverlay(marker);
		<%
		String sql100 = "SELECT LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehcode+" where concat(TheFieldDataDate,TheFieldDataTime)>='"+ thedate+thetime+"' and LatinDec>0 order by TheFieldDataDate Asc,TheFieldDataTime Asc";
		ResultSet rs100 = st.executeQuery(sql100);
		while(rs100.next())
			
		{
			lat1 = rs100.getString("lat1"); 
			lon1 = rs100.getString("lon1");
			
			thedate100= rs100.getDate("TheFieldDataDate");
			thetime100 = rs100.getString("TheFieldDataTime");
			long tdate = thedate100.getTime();
			location100= rs100.getString("TheFieldSubject");
				
			if(Double.parseDouble(lat)-Double.parseDouble(lat1) >0.00005 || Double.parseDouble(lon)-Double.parseDouble(lon1) >0.00005 ||Double.parseDouble(lat1)-Double.parseDouble(lat) >0.00005 || Double.parseDouble(lon1)-Double.parseDouble(lon) >0.00005  )
			{
				%>
				var polyline = new GPolyline([new GLatLng(<%= lat%>,<%= lon%>),new GLatLng(<%= lat1%>,<%= lon1%>)], "#00FF00",  10);
				map.addOverlay(polyline);
				<%
			}
			
			lat=lat1;
			lon=lon1;
			
			Lat=Double.valueOf(lat);
			Lon=Double.valueOf(lon);
			
			}
		
		/*String sqltoday="SELECT LatinDec,LatinDec+0.0001 as lat1,LonginDec,LonginDec+0.0001 as lon1,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehcode+" where TheFieldDataDate='"+new SimpleDateFormat("yyyy-MM-dd").format(today)+"' and LatinDec>0 order by TheFieldDataTime desc limit 1";
		System.out.println("sqltoday::>>"+sqltoday);		
		ResultSet rstoday=stmtoday.executeQuery(sqltoday);
		if(rstoday.next())
		{
			System.out.println("inside if block");
		
			lat3 = rstoday.getString("lat1"); 
			lon3 = rstoday.getString("lon1");
			
			thedate3= rstoday.getDate("TheFieldDataDate");
			thetime3 = rstoday.getString("TheFieldDataTime");
			long tdate3 = thedate3.getTime();
			location3= rstoday.getString("TheFieldSubject");
		}*/
			
		%>
		var point3 = new GLatLng(<%=lat1%>,<%= lon1%>);
		map.setCenter(point3,9);
		
		var marker33 = createMarker3(point3,"<div class='bodyText'><font size='2' face='arial'><b>Current Location</b>  <%= thedateformat100%> <%= thetime100%> <%= location100%></font></div>","<div class='bodyText'><%= vehregno%><br><%= thedateformat100%> <%= thetime100%><br> <%= location100%></div>",<%= lat1%>,<%= lon1%>);
		map.addOverlay(marker33);
		

		
		var point1 = new GLatLng(<%=endlat%>,<%= endlong%>);
		map.setCenter(point1,9);
		
		var marker = createMarker2(point1,"<div class='bodyText'><font size='2' face='arial'><b>End Location</b>  <%= endLocation%></font></div>","<div class='bodyText'><%= vehregno%><br><%= endLocation%></div>",<%= endlat%>,<%= endlong%>);
		map.addOverlay(marker);
		<%
		
	
//**********************************************************
		

}
catch(Exception e)
{
	out.print("Exception--->"+e);
	%>
		
	<%
}finally{
	conn.close();
}
%>

document.getElementById("side_bar").innerHTML = side_bar_html;
}
}



</script>
<table width="100%" border="1" bgcolor="white">
<tr><td id="img" width="15%" valign="top">
		<table width="100%" border="1" class="stats" valign="top">
			<tr><th colspan="2">Violations</th></tr>
			<tr><td class="hed" colspan="2"><img src="../images/mm_20_red.png" align="left"> Start Location</td></tr>
			<tr><td class="hed" colspan="2"><img src="../images/mm_20_blue.png" align="left"> Last Location</td></tr>
			<tr><td class="hed" colspan="2"><img src="../images/mm_20_black.png" align="left"> Current Location </td></tr>
			<tr></tr>
			<form action="addwaypoint.jsp" name="waypointform" method="get" >
			<tr><th colspan="2">Latitude & Longitude </th></tr>
			<tr><td class="hed">Latitude: </td>
			    <td class="hed"><input type="text" name="lon" id="lon" width="15" class="formElement" readonly></td>
			    </tr>
			<tr><td class="hed">Longitude: </td>
			    <td class="hed"><input type="text" name="lat" id="lat" width="15" class="formElement" readonly></td>
			    </tr>
			    </form>
			    
		</table>	
		<div id="side_bar"  style="overflow:auto; height:360px;" align="left" ></div>
		
	</td>


<td width="85%" valign="top">
<div id=map style="height: 600px"></div>
</td></tr>



</body>
<%@ include file="footerhtml.jsp" %>
