<%@ include file="headerhtml.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.01 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
 <%
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader ("Expires", 0);
%>
<%!
Connection conn;
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st = conn.createStatement();
Statement st1 = conn.createStatement();
Statement st11 = conn.createStatement();
String routeName=request.getParameter("owner");
%>
<%@page import="java.util.*"%><html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
     <noscript><b>JavaScript must be enabled in order for you to use Google Maps.</b> 
      However, it seems JavaScript is either disabled or not supported by your browser. 
      To view Google Maps, enable JavaScript by changing your browser options, and then 
      try again.
    </noscript>
    <script type="text/javascript">
function updateTrip()
{
	//alert("hi");
	var j=0;
	var tripid = new Array();
	var queryString="updatetrip.jsp?";
	var list=document.getlatlong.list;
	var len1=list.length;
	if(len1==undefined)
	{
		if(list.checked==true)
		{
			tripid[j]=document.getlatlong.list.value;
			//alert(tripid);
			j++;
		}
	}
	else
	{
		for (i = 0,j=0; i < list.length; i++)
		{
			if(list[i].checked == true )
			{
				tripid[j]=document.getlatlong.list[i].value;
				//alert(tripid);
				j++;
			}
		} 
		//alert(tripid[0]);
		
	}
	if(tripid.length!=0)
	{
	document.getElementById("len").value=tripid.length;
	document.getlatlong.action=queryString;
	var action=confirm("Are you sure you want to delete the Trip");
	//alert(action);
	if(action==true)
	{
	document.getlatlong.submit();
	//alert(queryString);
	}
	else
	{
		return;
	}
	}
	else
	{
		alert("Please Select a Trip id to delete");
	}
}
function callfun()
{
	var aa=document.getlatlong.owner.value;
	if(!(aa=="Select"))
	{	
		document.getlatlong.submit();
	}
}

</script>
    <title>Google Maps API Sample</title>
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAC-A9tpraq7fsC3Gl5VonjxT38pGqNDZCmueCKFpWF2V1m-Tr9RSZ-QIzawUvCwQ-y04XlsBkgiClZQ" type="text/javascript"></script>
    <script type="text/javascript">

    var map;
    var geoXml;
    var toggleState = 1;
    var side_bar_html = "<table><tr><td></td><td><b>Tripid</b></td><td align=\"left\"><b>Distance</b></td><td><b>Destination</b></td></tr>";
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
    function initialize() {
      if (GBrowserIsCompatible()) {
                
      }
    }
	function myclick(action) {
        if (GBrowserIsCompatible()) {
        	//var input=document.getlatlong.list;
        	var j=0;
        	if(action!="default")
        	{
        	var list=document.getlatlong.list;
			var len=list.length;
			
        	if(len==undefined)
        	{
            	
				if(list.checked==true)
				{
					var tripid=list.value;
					var filename="http://myfleetview.com/siteadmin/KMLFiles/"+tripid+".kml";
        			geoXml = new GGeoXml("http://myfleetview.com/siteadmin/KMLFiles/ALLbaseKMLFORCASTROLROUTES.kml"); 
        			var route=geoXml+i;
        			route= new GGeoXml(filename);
    				if(j==0)
    		        {
        		     
        		    map = new GMap2(document.getElementById("map_canvas"));
        		    map.setCenter(new GLatLng(18.80,80.1),5);
        		    map.addControl(new GMapTypeControl(1));
    		  		map.enableScrollWheelZoom();
    		  		map.addControl(new GSmallMapControl());
    		  		map.addControl(new GScaleControl());
    		        map.clearOverlays();
    		        map.addOverlay(geoXml);
    		        map.addOverlay(route);
    		        j++;
    		        }
    		        else
    		        {
    		         map.addOverlay(route);
        		        }
				}
				else
				{
					 map.clearOverlays();
	            		geoXml = new GGeoXml("http://myfleetview.com/siteadmin/KMLFiles/ALLbaseKMLFORCASTROLROUTES.kml"); 
	        			map.addOverlay(geoXml); 
				}
            	
            }
        	else
        	{
        		for (i = 0,j=0; i < list.length; i++)
            	{
            		if(list[i].checked == true )
            		{
            			var tripid=document.getlatlong.list[i].value;
            			
            			var filename="http://myfleetview.com/siteadmin/KMLFiles/"+tripid+".kml";
            			geoXml = new GGeoXml("http://myfleetview.com/siteadmin/KMLFiles/ALLbaseKMLFORCASTROLROUTES.kml"); 
            			var route=geoXml+i;
            			route= new GGeoXml(filename);
        				if(j==0)
        		        {
            		     
            		    map = new GMap2(document.getElementById("map_canvas"));
            		    map.setCenter(new GLatLng(18.80,80.1),5);
            		    map.addControl(new GMapTypeControl(1));
        		  		map.enableScrollWheelZoom();
        		  		map.addControl(new GSmallMapControl());
        		  		map.addControl(new GScaleControl());
        		        map.clearOverlays();
        		        map.addOverlay(geoXml);
        		        map.addOverlay(route);
        		        j++;
        		        }
        		        else
        		        {
        		         map.addOverlay(route);
            		        }
        		  		
        		  		
        		  		
        		  		
                	}
            	}  
            	if(j==0)
            	{
            		 map.clearOverlays();
            		geoXml = new GGeoXml("http://myfleetview.com/siteadmin/KMLFiles/ALLbaseKMLFORCASTROLROUTES.kml"); 
        			map.addOverlay(geoXml); 
                }
            }
        	
        	
        	}
        	else
        	{
            	
            			geoXml = new GGeoXml("http://myfleetview.com/siteadmin/KMLFiles/ALLbaseKMLFORCASTROLROUTES.kml");
 	        	        map = new GMap2(document.getElementById("map_canvas"));
        	            map.setCenter(new GLatLng(18.80,80.1),5);
        	            map.addControl(new GMapTypeControl(1));
        				map.enableScrollWheelZoom();
        				map.addControl(new GSmallMapControl());
        				map.addControl(new GScaleControl());
        				map.addOverlay(geoXml);
            }
        }
      }
    

    </script>
  </head>
  <body onload="myclick('default')" onunload="GUnload()" style="font-family: Arial;border: 0 none;">
 
    <form name="getlatlong" action="" method="get">
<table border="1" bgcolor="white" align="center">
<tr>
<td colspan="2">
<table width="100%" align="center" >

			<tr>
			<td align="center">
			<font  size="3" ><b>All Castrol Routes</b></font></td>
			<input type="hidden" id="len" name="len" value="0"/>
			</tr>
			<tr>
			<td>
				<b>Select Transporter :</b>
				<select name="owner" id="owner" onchange="callfun();"> 
				
				<option value="Select"> Select </option>
				<%
					HashMap<String, String> kmlTripDetails = null;
					List<HashMap<String, String>> optionGrpList = new ArrayList<HashMap<String, String>>();
					//List optionGrpList = new ArrayList();   
			        optionGrpList.clear();
					String sql1="SELECT rid,startpalce,endplace,tripid,kmlfilename FROM t_kmltrip where status=1 group by startpalce,endplace order by startpalce,endplace";
		  			ResultSet rs1=st1.executeQuery(sql1);
				
		  		while(rs1.next())
		  		{
		  			kmlTripDetails= new java.util.HashMap<String, String>();
		  			kmlTripDetails.put("startpalce",rs1.getString(2));
		  			kmlTripDetails.put("endplace",rs1.getString(3));
		  			optionGrpList.add(kmlTripDetails); 
		  			//optionGrpList.add(request.getParameter("owner").toString());
		  		}
		  		String selected="";
		  		for (Iterator<HashMap<String, String>> iterator = optionGrpList.iterator(); iterator.hasNext();)
				{
					HashMap<String,String>	options = (HashMap<String, String>) iterator.next();
					if(routeName!=null && routeName.trim().length()!=0 && routeName.trim().equalsIgnoreCase(options.get("startpalce")+"-"+ options.get("endplace")) )
			  		{
						selected="selected='selected'";
					 %>
					 
					 <option value='<%=options.get("startpalce")+"-"+ options.get("endplace")%>' <%= selected%>><%=options.get("startpalce")+"-"+ options.get("endplace")%></option>
				<%	
			  		}
					else
					{
						%>
						 <option value='<%=options.get("startpalce")+"-"+ options.get("endplace")%>'><%=options.get("startpalce")+"-"+ options.get("endplace")%></option>
						<%
					}
				}
		  			
			%>
			</select> 
			</td>
			</tr>
	
</table>
<%

String sql=null;
double lat=0.00,lon=0.00;
%>
</td>
</tr>
<tr>
<td width="20%" valign="top" >
<table width="100%" border="0" valign="topo">
<%
String flag=request.getParameter("flag");

if(routeName!=null)
{
%>
<tr bgcolor="#2696B8"><th colspan="1" style="border: none;"><font color="#FFFFFF"> All Loacations for <%=routeName %></font>
<input type="hidden" name="routeName" id="routeName" value="<%=routeName %>"/>
</th></tr>

<% }else{ %>
<tr bgcolor="#2696B8"><th colspan="1" style="border: none;"><font color="#FFFFFF">All Loacations</font></th></tr>
<% }%>
<tr>
<td style="border: none;">           <!-- =========== side_bar with scroll bar ================= -->
 
<div id="side_bar"  style="overflow:auto;width: 200px; height:550px" align="left" ></div>

</td>
</tr>           <!-- ===================================================== -->
</table>	
</td>
 <!-- =========== map ================= -->
<td  valign="top">

       <div id="map_canvas" style="width: 600px; height: 550px"></div>
 <script type="text/javascript">

  
      <%
try
{
	 if(flag!=null && flag.trim().length()!=0 && flag.equalsIgnoreCase("true"))
	 {
	 	%>
	 	alert("Sucessfully Deactivated");
	 	<%
	 }
	String startPlace="-",endPlace="-",html1=null,kmlFileName="-",tripId="-";
	Double distance=0.0;
	int rId=0;
	if(routeName != null)
	{
		String start=routeName.substring(0,routeName.indexOf("-"));
		String end=routeName.substring(routeName.indexOf("-")+1,routeName.trim().length());
		System.out.println(start+" "+end);
		
	String EndPlace="",color="",finalcolor="";	
	sql="SELECT * FROM t_kmltrip where status=1 and startpalce='"+start+"' and endplace='"+end+"' order by startpalce,endplace";
	//sql="select WareHouseCode,WareHouse,Owner,Latitude,Longitude from t_warehousedata where Owner like '"+ OwnerName +"'";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		rId=rst.getInt("rid");
		tripId=rst.getString("tripid");
		startPlace=rst.getString("startpalce");
		endPlace=rst.getString("endplace");
		distance=rst.getDouble("Distance");
		kmlFileName=rst.getString("kmlfilename");
		color=rst.getString("color");
		if("5f14780A".equalsIgnoreCase(color)){
			finalcolor="#0A7814";
		}else if("5f14F014".equalsIgnoreCase(color)){
			finalcolor="#14F014";
		}else if("5f14F0FF".equalsIgnoreCase(color)){
			finalcolor="#FFF014";
		}else if("5f7814B4".equalsIgnoreCase(color)){
			finalcolor="#B41478";
			
		}else if("5f143CB4".equalsIgnoreCase(color)){
			finalcolor="#B43C14";
		}else if("5fFF78F0".equalsIgnoreCase(color)){
			finalcolor="#F078FF";
		}else if("5f1478AA".equalsIgnoreCase(color)){
			finalcolor="#AA7814";
		}else if("5f781E78".equalsIgnoreCase(color)){
			finalcolor="#781E78";
		}else if("5f7800F0".equalsIgnoreCase(color)){
			finalcolor="#F00078";
		}else if("5fF0FA14".equalsIgnoreCase(color)){
			finalcolor="#14FAF0";
		}else if("5fF07814".equalsIgnoreCase(color)){
			finalcolor="#1478F0";
		}else{
			finalcolor="#FFFFFF";
		}
		String sql11="select * from db_gps.t_completedjourney where tripid='"+tripId+"' order by KmTravelled desc ";
		ResultSet rs=st11.executeQuery(sql11);
		System.out.println(sql11);
		if(rs.next()){
		EndPlace=rs.getString("EndPlace");
		}
		
		//html1="http://myfleetview.com/siteadmin/KML/"+kmlFileName;
		System.out.println(EndPlace);
%>

   // var gx = new GGeoXml(kmlFileName);
	//alert(gx.hasLoaded());
	//map.addOverlay(gx);
side_bar_html += '<tr bgcolor=<%=finalcolor%>><td><input type="checkbox" id="<%=rId%>" name="list" value="<%=tripId%>" onclick="javascript:myclick(\'second\');"> </td><td><font color="#FFFFFF"><%=tripId%></font><br><input type="hidden" id="rid<%=rId %>" name="rid<%=rId %>" value="<%=tripId %>"><input type="hidden" id="geoId<%=rId %>" value=""></td><td align="center"><font color="#FFFFFF"><%=distance%></font></td><td><font color="#FFFFFF"><%=EndPlace%></font></td></tr>';
<%

	} 
	%>
	    side_bar_html +='</table><table><tr><td><input type="button" id="Deactivate" value="Deactivate" onclick="updateTrip();"></td></tr></table>'
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
}catch(Exception e){
	
	
}
%>
</script>
</td>
 <!-- ===================================================== -->	
</tr>  
</table>
</form>
  </body>
</html>