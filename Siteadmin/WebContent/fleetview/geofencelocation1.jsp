<%@ include file="headerhtml.jsp" %>
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
<form name="geofenceform" action="updategeofencing.jsp" method="get" onsubmit="return validate();">
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="2"><b><i>Geofence Location</i></b></font></td></tr>
<tr>
<td>
<%!
	Statement st;
	String sql; 
%>
<%
	try
		{
			st=conn.createStatement();
			
			String res=request.getParameter("res");
			String duplicate=request.getParameter("duplicate");
			String trans=request.getParameter("trans");
			String loccode=request.getParameter("loccode");
			String locname=request.getParameter("locname");
		
			
			if(!(duplicate==null) && duplicate.equalsIgnoreCase("yes"))
			{
				%>
				<div align="center"><font color="red" size="2"><b><i>Duplicate Record for Transporter <%=trans %> </i></b></font></div>				
				<%
			}
			if(!(null==res))
			{
				%>
				<div align="center"><font color="red" size="2"><b><i>Record Update Successfully !!</i></b></font></div>				
				<%
			}
	
%>
<table border="0" width="100%" align="center">
<tr>
	<td bgcolor="#f5f5f5"><b>Geofence Type :</b></font></td>
	<td bgcolor="#f5f5f5"><input type="radio" name="geofencetype" id="geofencetype" value="latlon"  checked onclick="getGeofenceInfo(this);"><font size="2">Lat Lon Based</font>
	&nbsp;&nbsp;&nbsp; <input type="radio" name="geofencetype" id="geofencetype" value="datetime"  onclick="getGeofenceInfo(this);"><font size="2">Date Time Based</font></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><b>Transporter / Group :</b></td><td bgcolor="#f5f5f5">
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
<td bgcolor="#f5f5f5"><b>Vehicle :</b></td><td bgcolor="#f5f5f5">
<div id="vehiclediv">
<select name="vehicle" id="vehicle">
<option value="Select">Select</select>
</select>
</div>
</td>
</tr>
<tr id="date" style="display:none">
<td bgcolor="#f5f5f5"><b>Date :</b></td>
<td bgcolor="#f5f5f5">
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
</td>
</tr>
<tr id="time" style="display:none">
<td bgcolor="#f5f5f5"><b>Time :</b></td><td bgcolor="#f5f5f5">

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
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><b>Location Code :</b></td><td bgcolor="#f5f5f5"><input type="text" name="locationcode" id="locationcode"></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><b>Location Name :</b></td><td bgcolor="#f5f5f5"><input type="text" name="location" id="location"></td>
</tr>
<tr id="lat1">
<td bgcolor="#f5f5f5"><b>Latitude :</b></td><td bgcolor="#f5f5f5"><input type="text" name="lat" id="lat"></td>
</tr>
<tr id="lon1">
<td bgcolor="#f5f5f5"><b>Longitude :</b></td><td bgcolor="#f5f5f5"><input type="text" name="lon" id="lon"></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><b>Location Type : </b></td><td bgcolor="#f5f5f5">
<select name="loctype" id="loctype">
<option value="-">-</option>
<option value="Zone">Zone</option>
<option value="WH">WH</option>
</select>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><b>Add to Depot List :</b></td><td bgcolor="#f5f5f5"><input type="radio" name="add" id= "depot" value="Yes"><b>Yes</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="add" value="No" Checked><b>No</b></td>
</tr>
<tr>
<td bgcolor="#2696B8" colspan="2" align="Left"><input type="submit" name="submit" value="submit"></td>
<td bgcolor="#2696B8" colspan="2" align="center"><input type="button" name="" value="View Geofenced Data" onClick="window.open('viewgeofence.jsp', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"></input></td>)></td>
</tr>
</table>
</form>
<%
	}catch(Exception e)
	{
		out.print("Exception --->"+e);
	}

%>
</td>
</tr>
</table>
<%@ include file="footerhtml.jsp" %>