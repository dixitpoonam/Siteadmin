<%@ page language="java" contentType="application/vnd.ms-excel; charset=gb2312"  import="java.sql.*" import="java.util.*" import=" java.text.*"  pageEncoding="UTF-8"%>

<% response.setContentType("application/vnd.ms-excel");
String filename="UnitData.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.util.Date"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search the Unit Data</title>
</head>
<body>
<%!
String MM_dbConn_USERNAME="site";
String MM_dbConn_PASSWORD="1@s2te";
String MM_dbConn_STRING1="jdbc:mysql://localhost/db_avlalldata";

Connection conn,conn1;
Statement st1;
String sql, unitid,thedate,thedate1,thedate2,limit;
%>
<%
try{
	Class.forName("org.gjt.mm.mysql.Driver"); 
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st1 = conn1.createStatement();
	%>
	<table border="0" width="100%" align="center">
	<tr>
	<td>
	<%
	if(!(null==request.getQueryString()))
	{
		unitid=request.getParameter("unitid");
		thedate=request.getParameter("data");
		limit=request.getParameter("limit");
		thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
		thedate2=thedate1.replace("-","_");
		%>
		<table border="0" width="100%" align="center">
		<tr>
		<td colspan="8"  align="center">The Data of unit <%=unitid %> on <%=thedate %>
		</td>
		</tr>
		
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">Stored Time</td>
		<td class="hed" align="center">Stamp Date Time</td>
		<td class="hed" align="center">MailBody</td>
		<td class="hed" align="center">Status</td>
		</tr>
		
		<%
		int i = 0;
		sql="SELECT Body,status,storedtime FROM db_avlalldata.t_ipGT"+thedate2+"  where Unitid='"+unitid.trim()+"' order by storedtime desc "+limit;
		ResultSet rst1=st1.executeQuery(sql);
		while(rst1.next())
		{	
		%>
			<tr>
			<td  align="center"><%=++ i %></td>
			<td  align="center"><%=rst1.getTime("storedtime") %></td>
			<td  align="center">-</td>
			<td  align="left"><%=rst1.getString("Body") %></td>
			<td  align="center"><%=rst1.getString("status") %></td>
			</tr>
		<%
	
		}
		%>
		  </table>
		<%
	}%>
	</td>
	</tr>
	</table>
	<%
	
}catch(Exception e)
{
	out.print("Exceptions ----->"+e);
}
finally
{
	try{
	conn1.close();
	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>

</body>
</html>
