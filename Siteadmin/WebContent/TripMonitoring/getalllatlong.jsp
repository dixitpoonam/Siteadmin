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

function callfun()
{
	var aa=document.getlatlong.owner.value;
	if(!(aa=="Select"))
	{	
		document.getlatlong.submit();
	}
}

</script>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
<!-- you can use tables or divs for the overall layout -->
<table border="1" bgcolor="white" align="center">
<tr>
<td colspan="2">
<table width="100%" align="center" >
<form name="getlatlong" action="" method="get">
			<tr>
			<td align="center">
			<font  size="3" ><b>All Vehicles</b></font></td>
			</tr>
			<tr>
				<b>Select Transporter :</b>
				<select name="owner" id="owner" onchange="callfun();"> 
				
				<option value="Select"> Select </option>
				<%
					List optionGrpList = new ArrayList();   
			        optionGrpList.clear();
					String sql1="select distinct(Owner) from t_warehousedata";
		  			ResultSet rs1=st1.executeQuery(sql1);
				
		  		while(rs1.next())
		  		{
		  			 optionGrpList.add(rs1.getString("owner").toString()); 
		  			//optionGrpList.add(request.getParameter("owner").toString());
		  		}
		  	    Collections.sort(optionGrpList);
		  		for( int optionCntr = 0 ;  optionCntr < optionGrpList.size();   optionCntr ++)
		        {  
					
			 %>
				 <option value='<%=optionGrpList.get(optionCntr)%>'><%=optionGrpList.get(optionCntr)%></option>
			<%		
		 		 }
		  		
			%>
			</select> 
			</tr>
	</form>
</table>
<%
String OwnerName=request.getParameter("owner");
String sql=null;
double lat=0.00,lon=0.00;
%>
</td>
</tr>
<tr>
<td width="20%" valign="top">
<table width="100%" border="1" valign="topo">
<%
if(OwnerName!=null)
{
%>
<tr><th colspan="1">All Loacations for <%=OwnerName %></th></tr>
<% }else{ %>
<tr><th colspan="1">All Loacations</th></tr>
<% }%>
</table>
           <!-- =========== side_bar with scroll bar ================= -->
 
<div id="side_bar"  style="overflow:auto; height:390px;" align="left" ></div>
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
	      	var side_bar_html = "";
	 		var combo="<select name='select1' id='select1' class='bodyText'>";
	 		var combo1="</select>";
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
				cIcon.image = '../images/mm_20_red.png';
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
		      	GEvent.addListener(marker, "mouseover", function() { 
				map.setCenter(new GLatLng(lat,lon),9);
		        marker.openInfoWindowHtml(html1);
		        }); 
		     	gmarkers[i] = marker;
		      htmls[i] = html1;
		       
		       side_bar_html += '<a href="javascript:myclick(' + i + ','+lat+','+lon+')" class="bodyText" onMouseOver="javascript:myclick(' + i + ','+lat+','+lon+')"  title="">'+name+'</a><br>';
		    	//combo +='<option value="+i+" onClick="javascript:myclick(' + i + ','+lat+','+lon+')" >'+name+'</option>';
		    	i++;
		        return marker;
		      }
<%
try
{
	String wareHouseCode="-",wareHouse="-",owner="-",html1=null;
	if(OwnerName != null)
	{
	sql="select WareHouseCode,WareHouse,Owner,Latitude,Longitude from t_warehousedata where Owner like '"+ OwnerName +"'";
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
		document.getElementById("side_bar").innerHTML = side_bar_html;
	<%}//end of if
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
