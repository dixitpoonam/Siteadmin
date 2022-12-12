<%@ include file="conn.jsp" %>
<style type="text/css">@import url(../jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="../jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/calendar-setup.js"></script>
<script language="javascript">
function getVehicles(trans)
{
		
var xmlhttp;
if (window.XMLHttpRequest)
  {
  // code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else if (window.ActiveXObject)
  {
  // code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
else
  {
  alert("Your browser does not support XMLHTTP!");
  }
xmlhttp.onreadystatechange=function()
{
if(xmlhttp.readyState==4)
  {
  //alert(xmlhttp.responseText);
  document.getElementById("vehiclediv").innerHTML=xmlhttp.responseText;
  }
}
xmlhttp.open("GET","getVehicles.jsp?UserName="+trans,true);
xmlhttp.send(null);
		
	}
	
	function validate()
	{
		if(document.tripform.geofencetype[1].checked==true)
		{
			if(document.getElementById("trans").value=="Select")
			{
				alert("Please select the Transporter /Group Name !");
				return false;
			}
			if(document.getElementById("vehicle").value=="Select")
			{
				alert("Please select the vehicle Registration Number !");
				return false;
			}
			if(document.getElementById("thedate").value=="")
			{
					alert("Please select the Date !");
					return false;
			}
			if(document.getElementById("thetime").value=="")
			{
				alert("Please select the Time !");
				return false;
			}
		}
		else {
				if(document.tripform.geofencetype[0].checked==true)
				{
					if(document.getElementById("lat").value=="")
					alert("Please enter the latitude  !");
					return false;
				}
				if(document.tripform.geofencetype[0].checked==true)
				{
					if(document.getElementById("lon").value=="")
					alert("Please enter the Longitude !");
					return false;
				}
		}
			if(document.getElementById("locationcode").value=="")
			{
				alert("Please enter the Location code !");
				return false;
			}
			if(document.getElementById("location").value=="")
			{
				alert("Please enter the Location Name !");
				return false;
			}
			return true;
	}

	function openMapWindow()
	{
		if(document.getElementById("vehicle").value=="Select")
		{
			alert("Please Select the vehicle registration number !!");
		}
		else if(document.getElementById("thedate").value=="")
		{
			alert("Please Select the Date !!");
		}
		else if(document.getElementById("thetime").value=="")
		{
			alert("Please Select the Time !!");
		}
		else
		{
			var vehcode=document.getElementById("vehicle").value;
			var thedate=document.getElementById("thedate").value;
			var thetime=document.getElementById("thetime").value;
			window.open("showsmallmap.jsp?vehcode="+vehcode+"&thedate="+thedate+"&thetime="+thetime,"win1","width=500,height=400,location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0");
		}
	}


function getGeofenceInfo(x)
{
	//alert ("In fun");
	//alert("value of x--->"+x);
	if(x.value=="datetime")
	{
		//alert("value of x in if --->");
		document.geofenceform.lat.style.dipslay="hidden";
		document.getElementById("lat1").style.display='none';
		document.geofenceform.lon.style.dipslay="hidden";
		document.getElementById("lon1").style.display='none';
		document.getElementById("veh").style.display='';
		document.geofenceform.vehicle.style.visibility="visible";
		document.getElementById("date").style.display='';
		document.geofenceform.thedate.style.visibility="visible";
		document.getElementById("time").style.display='';
		document.geofenceform.thetime.style.visibility="visible";
		document.getElementById("trigger").style.display='';
	}
	else
	{
		document.geofenceform.lat.style.visibility="visible";
		document.getElementById("lat1").style.display='';
		document.geofenceform.lon.style.visibility="visible";
		document.getElementById("lon1").style.display='';
		document.geofenceform.vehicle.style.dipslay='hidden';
		document.getElementById("veh").style.display='none';
		document.geofenceform.thedate.style.dipslay='hidden';
		document.getElementById("date").style.display='none';
		document.geofenceform.thetime.style.dipslay='hidden';
		document.getElementById("time").style.display='none';
		document.getElementById("trigger").style.display='none';
	}
	
}
</script>
<form name="geofenceform" action="insertgeofencing.jsp" method="post" onsubmit="return validate();">
<table border="0" align="center" width="100%">
<tr><td align="center" bgcolor="#2696B8"><font color="white" size="3"><b><i>Geofence Location</i></b></font></td></tr>
<tr>
<td>
<%!
	Statement st;
	String sql; Connection conn;
%>
<%
	try
		{ 
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
			String res=request.getParameter("res");
			String duplicate=request.getParameter("duplicate");
			String trans=request.getParameter("trans");
			String loccode=request.getParameter("loccode");
			String locname=request.getParameter("locname");
		
			
			if(!(duplicate==null) && duplicate.equalsIgnoreCase("yes"))
			{
				%>
				<script type="text/javascript">
                alert("Duplicate Record!!");
                </script>						
				<%
			}
			if(!(null==res))
			{
				%>
				<script type="text/javascript">
                alert("Record Inserted Successfully !!");
                opener.Reload();
                 window.close();
                </script>
								
				<%
			}
	
%>
<table border="0" width="100%" align="center">
<tr>
	<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Geofence Type :</b></font></td>
	<td bgcolor="#f5f5f5"><input type="radio" name="geofencetype" id="geofencetype" value="latlon"  checked onclick="getGeofenceInfo(this);"><font size="2" face="Arial">Lat Lon Based</font>
	&nbsp;&nbsp;&nbsp; <input type="radio" name="geofencetype" id="geofencetype" value="datetime"  onclick="getGeofenceInfo(this);"><font size="2" face="Arial">Date Time Based</font></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Transporter / Group :</b></font></td><td bgcolor="#f5f5f5">
	<select name="trans" id="trans" onchange="getVehicles(this.value);">
	<option value="Select">Select</option>
	<%
	sql="select TypeValue from(select distinct FullName as TypeValue from t_security where TypeOfUser <> 'SUBUSER' union select distinct(GPName) as TypeValue from t_group where SepReport='Yes')y order by TypeValue Asc";
	//select distinct(TypeValue) as TypeValue from t_security where TypeOfUser in ('Transporter','GROUP') order by TypeValue";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
	%>
	<option value="<%=rst.getString("TypeValue")%>"><%=rst.getString("TypeValue")%></option>	
	<%
	}	
	%>
	</select>
</td>
</tr>
<tr id="veh" style="display:none">
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Vehicle :</b></font></td><td bgcolor="#f5f5f5">
<div id="vehiclediv">
<select name="vehicle" id="vehicle">
<option value="Select">Select</select>
</select>
</div>
</td>
</tr>
<tr id="date" style="display:none">
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Date :</b></font></td>
<td bgcolor="#f5f5f5"><font size="2" face="Arial">
<input type="text" id="thedate" name="thedate" size="15" readonly/>
<img src="../images/calendar.png" id="trigger" border="0">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "thedate",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>
</font>
</td>
</tr>
<tr id="time" style="display:none">
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Time :</b></font></td><td bgcolor="#f5f5f5">
<font size="2" face="Arial">
<input type="text" name="thetime" id="thetime" size="15" value="">
<img src="../images/calendar.png" id="trigger1"  border="0">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "thetime",         // ID of the input field
      ifFormat    : "%H:%M:%S",     // the date format
      button      : "trigger1",       // ID of the button
      showsTime	: "true"				// Allow Time Selection
    }
  );
</script>
&nbsp;&nbsp;&nbsp;&nbsp;
<a href="#" onclick="openMapWindow();">Click here to view the location on map.</a>
</font>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Location Code :</b></font></td><td bgcolor="#f5f5f5"><font size="2" face="Arial"><input type="text" name="locationcode" id="locationcode"></font></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Location Name :</b></font></td><td bgcolor="#f5f5f5"><font size="2" face="Arial"><input type="text" name="location" id="location"></font></td>
</tr>
<tr id="lat1">
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Latitude :</b></font></td><td bgcolor="#f5f5f5"><font size="2" face="Arial"><input type="text" name="lat" id="lat"></font></td>
</tr>
<tr id="lon1">
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Longitude :</b></font></td><td bgcolor="#f5f5f5"><font size="2" face="Arial"><input type="text" name="lon" id="lon"></font></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Location Type : </b></font></td><td bgcolor="#f5f5f5">
<select name="loctype" id="loctype">
<option value="-">-</option>
<option value="Zone">Zone</option>
<option value="WH">WH</option>
</select>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Add to Depot List :</b></font></td><td bgcolor="#f5f5f5"><font size="2" face="Arial"><input type="radio" name="add" id= "depot" value="Yes"><b>Yes</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="add" value="No" Checked><b>No</b></font></td>
</tr>
<tr>
<td bgcolor="#2696B8" colspan="2" align="center"><input type="submit" name="submit" value="submit"></td>
</tr>
</table>
</form>
<%
	}catch(Exception e)
	{
		out.print("Exception --->"+e);
	}finally{
		conn.close();
	}

%>
</td>
</tr>
</table>
