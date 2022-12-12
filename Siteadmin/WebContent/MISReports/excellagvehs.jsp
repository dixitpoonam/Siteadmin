<%@ page contentType="application/vnd.ms-excel; charset=gb2312" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<% response.setContentType("application/vnd.ms-excel");

String filename="lagvehicles.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>

<%@ include file="conn.jsp" %>
<%! Connection con1; %>
<%

try
{
	
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1=con1.createStatement();
	ResultSet rs1=null;
	String sql1="";
	
	String date1=request.getParameter("date1");
%>

<table border="0" width="90%" align="center">
<tr>
    <td bgcolor="#f5f5f5" align="center"> <b> <font color="" size="2"> Lag Data on <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1))%> </font> </b> </td>
    
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
			<td bgcolor="#f5f5f5"> <%=rs1.getString("Location")%> </td>
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

