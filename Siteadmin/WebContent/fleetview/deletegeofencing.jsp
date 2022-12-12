<head>
</head>
<body>

<%

String name=request.getParameter("name");
String code=request.getParameter("code");
String type=request.getParameter("type");
String trans=request.getParameter("trans");

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

System.out.println("name "+name);
System.out.println("code "+code);
System.out.println("type "+type);
System.out.println("trans "+trans);

String Msg=request.getParameter("Msg");
if(!(Msg==null) && Msg.equalsIgnoreCase("Yes"))
{
	%>
	<script type="text/javascript">
     alert("Record Deleted Successfully!!");
     opener.Reload();
     window.close();
     </script>	
	<%
}
else
	if(!(Msg==null) && Msg.equalsIgnoreCase("No"))
	{
		%>
		<script type="text/javascript">
         alert("Unable to delete the record!!");
        </script>		
		<%
	}
%>
<form name="deletegeofence" action="deletegeofence.jsp" method="post">
<table border="0" align="center" width="100%">
<tr><td align="center" bgcolor="#2696B8"><font color="white" size="3" face="Arial"><b><i>Delete Geofenced Location</i></b></font></td></tr>
<tr>
<td>
<table border="0" width="100%" align="center">
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Location Name :</b></font></td>
<td bgcolor="#f5f5f5"><input type="text" name="name" id="name" value="<%=name %>" readonly>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Location Code :</b></font></td>
<td bgcolor="#f5f5f5"><input type="text" name="code" id="code" value="<%=code %>" readonly></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2" face="Arial"><b>Location Type : </b></font></td>
<td bgcolor="#f5f5f5"><input type="text" name="loctype" id="loctype" value="<%=type %>" readonly>
<input type="hidden" name="trans" id="trans" value="<%=trans %>">
</td>
</td>


<tr>
<td bgcolor="#2696B8" colspan="2" align="center"><input type="submit" name="submit" value="submit"></td>
</tr>