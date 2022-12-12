<%@ include file="headerhtml.jsp" %>
<!-- <META HTTP-EQUIV=Refresh CONTENT='60; URL=onlineusers.jsp'>  -->
<html>
<head>
<script language="javascript">

function validate()
{ 
	
}


</script>

</head>
<form name="lagvehs" method="get" action="" onSubmit="return validate();">
<%!Connection con1; %>
<%
try{
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1=con1.createStatement();
	ResultSet rs1=null;
	String sql1="";
	
	String date1=request.getParameter("date1");
%>

<table border="0" width="90%" align="center">
<tr>
    <td bgcolor="#f5f5f5" align="center"> <b> <font color="" size="2"> Lag Data on <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1))%> </font> </b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="excellagvehs.jsp?date1=<%=date1%>"> <img src="../images/excel.jpg" width="15px" height="15px" border="0"/> </a> </td>
</tr>
<tr>
    <td align="center">
    	<table border="0" width="100%" align="center">
	    <tr>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Sr No </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Vehicle No </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Owner </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Location </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Lag (Hrs) </font> </td>
	    </tr>
<%
	int i=1;
	sql1="select * from t_vehiclelagdata where TheDate='"+date1+"' ";
	rs1=stmt1.executeQuery(sql1);
	while(rs1.next())	
	{ 
		double laghrs=rs1.getDouble("Lag");
		String lat=rs1.getString("Latitude");
		String lon=rs1.getString("Longitude");
		String loc=rs1.getString("Location");
	
		laghrs=laghrs/60;

		NumberFormat nf = DecimalFormat.getNumberInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);	
		nf.setGroupingUsed(false);
	
		String laghrsfrmtd=nf.format(laghrs);

%>

		<tr>
			<td bgcolor="#f5f5f5"> <%=i%> </td>
			<td bgcolor="#f5f5f5"> <%=rs1.getString("VehicleNo")%> </td>
			<td bgcolor="#f5f5f5"> <%=rs1.getString("OwnerName")%> </td>
			<td bgcolor="#f5f5f5"> <a href="#" onclick="popWin = open('mapwindow.jsp?lat=<%=lat%>&lon=<%=lon%>','myWin','width=500,height=500');popWin.focus();return false"> <%=rs1.getString("Location")%>  </a> </td>
			<td bgcolor="#f5f5f5"> <%=laghrsfrmtd%> </td>
		</tr>
<%		
		i++;
	}
%>
	</table>
    </td>			
</tr>
</table>

	
<%
}catch(Exception e)
{
	out.print("Exception---->"+e);
}
finally{
	con1.close();
}
%>
</table>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>
</html>

