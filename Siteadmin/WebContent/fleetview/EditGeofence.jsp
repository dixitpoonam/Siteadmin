
<head>
</head>
<body>
<script type="text/javascript">
function validate()
{
	//alert("Hii");
	
	if(document.getElementById("name").value.length==0)
	{
		alert("Please enter the locatio name!!");
		return false;
	}

	if(document.getElementById("code").value.length==0)
	{
		alert("Please enter the location code!!");
		return false;
	}
	return true;
}

</script>
<%

String name=request.getParameter("name");
String code=request.getParameter("code");
String type=request.getParameter("type");
String trans=request.getParameter("trans");
String lati=request.getParameter("lati");
String longi=request.getParameter("longi");

if(name==null)
{
	name="-";
}
if(code==null)
{
	code="-";
}
if(type==null)
{
	type="-";
}
if(trans==null)
{
	trans="-";
}
if(lati==null)
{
	lati="-";
}if(longi==null)
{
	longi="-";
}

System.out.println("name "+name);
System.out.println("code "+code);
System.out.println("type "+type);
System.out.println("trans "+trans);
String Msg=request.getParameter("Msg");

if(!(Msg==null) && Msg.equals("1"))
{
	%>
	<script type="text/javascript">
    alert("Please do some changes!!");
    </script>						
	<%
}else
	if(!(Msg==null) && Msg.equals("2"))
	{
		%>
		<script type="text/javascript">
	    alert("Duplicate Code!!");
	    </script>						
		<%
	}
	else
		if(!(Msg==null) && Msg.equals("3"))
		{
			%>
			<script type="text/javascript">
		    alert("Record Updated Successfully!!");
		    opener.Reload();
		    window.close();
		    </script>						
			<%
		}

%>

<form name="editgeofence" action="updategeofencing.jsp" method="post" onsubmit="return validate();">
<table border="0" align="center" width="100%">
<tr><td align="center" bgcolor="#2696B8"><font color="white" size="3" face="Arial"><b><i>Edit Geofenced Location</i></b></font></td></tr>
<tr>
<td>
<table border="0" width="100%" align="center">
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Location Name :</b></font></td><td bgcolor="#f5f5f5"><input type="text" name="name" id="name" value="<%=name %>">
<input type="hidden" name="name1" id="name1" value="<%=name %>"></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Location Code :</b></font></td><td bgcolor="#f5f5f5"><input type="text" name="code" id="code" value="<%=code %>">
<input type="hidden" name="code1" id="code1" value="<%=code %>"></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Latitude :</b></font></td><td bgcolor="#f5f5f5"><input type="text" name="lati" id="lati" value="<%=lati %>">
<input type="hidden" name="lati1" id="lati1" value="<%=lati %>"></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Longitude :</b></font></td><td bgcolor="#f5f5f5"><input type="text" name="longi" id="longi" value="<%=longi %>">
<input type="hidden" name="longi1" id="longi1" value="<%=longi %>"></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Location Type : </b></font></td><td bgcolor="#f5f5f5">
<select name="loctype" id="loctype">
<%
if(type.equalsIgnoreCase("-"))
{
%>
<option value="-" selected>-</option>
<%}else{ %>
<option value="-">-</option>
<%} 
if(type.equalsIgnoreCase("Zone"))
{
%>
<option value="Zone" selected>Zone</option>
<%}else{ %>
<option value="Zone">Zone</option>
<%} 
if(type.equalsIgnoreCase("WH"))
{
%>
<option value="WH" selected>WH</option>
<%}else{ %>
<option value="WH">WH</option>
<%} %>
</select>
<input type="hidden" name="type1" id="type1" value="<%=type %>">
<input type="hidden" name="trans" id="trans" value="<%=trans %>">
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Add to Depot List :</b></font></td>
<td bgcolor="#f5f5f5">
<input type="radio" name="add" id= "depot" value="Yes"><font size="2" face="Arial"><b>Yes</b></font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="add" value="No" Checked><font size="2" face="Arial"><b>No</b></font></td>
</tr>
</table>
</td>
</tr>
<tr>
<td></td>
</tr>
<tr>
<td bgcolor="#2696B8" colspan="2" align="center"><input type="submit" name="submit" value="submit"></td>
</tr>
</table>
</form>

</body>