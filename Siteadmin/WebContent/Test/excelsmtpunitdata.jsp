<%@ page language="java" contentType="application/vnd.ms-excel; charset=gb2312"  import="java.sql.*" import="java.util.*" import=" java.text.*"  pageEncoding="UTF-8"%>

<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename=showdatex+"_SMTPUnitData.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.util.Date"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search the Unit Data</title>
</head>
<body>

<%@ include file="conn.jsp" %>
<%!
Connection conn,conn1;
%>
<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st=null, st1=null;
String sql=null, unitid=null,thedate=null,thedate1=null,thedate2=null,limit="";
try{
	
	st=conn.createStatement();
	st1=conn1.createStatement();
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
		Date date1=new SimpleDateFormat("yyy-MM-dd").parse(thedate1);
		Date change= new SimpleDateFormat("yyyy-MM-dd").parse("2010-03-02");
		long startdate=date1.getTime();
		long changedate=change.getTime();
		long diff=startdate-changedate;
		//out.print(thedate+"  "+thedate1+"  "+thedate2);
		%>
		<table border="0" width="100%" align="center">
		<tr>
		<td colspan="8"  align="center">The Data of unit <%=unitid %> on <%=thedate %>
		</td>
		</tr>
		
		<%
		sql="select * from allconnectedunits where unitid='"+unitid+"' order by concat(TheDate,TheTime) desc limit 1";
		ResultSet rst1=st.executeQuery(sql);
		if(rst1.next())
		{
			%>
		<tr>
		<td colspan="8"  align="center">The current location of unit <%=unitid %> is  <B><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheDate"))+" "+rst1.getString("TheTime") +"   "+rst1.getString("Location")%></B></td>
		</tr>
			<%
		}
		%>
		<tr>
		<td  align="center">Sr.</td>
		<td  align="center">StoredTime</td>
		<td  align="center">Vehicle No</td>
		<td  align="center">Vehicle Code</td>
		<td  align="center">Transporter</td>
		<td  align="center">MailBody</td>
		<td  align="center">Unprocessed Stamps</td>
		<td  align="center">Unit Type</td>
		</tr>
		<%
		
		
			sql="select * from t_mails"+thedate2+"Processed where Unitid='"+unitid+"' order by storedtime desc "+limit;
	
		ResultSet rst=st1.executeQuery(sql);
		int i=1;
		while(rst.next())
		{
		%>
			<tr>
			<td  align="center"><%=i %></td>
			<td  align="center"><%=rst.getTime("StoredTime") %></td>
			<td  align="left"><%=rst.getString("VehRegNo") %></td>
			<td  align="right"><%=rst.getString("Vehid") %></td>
			<td  align="left"><%=rst.getString("Transporter") %></td>
			<td  align="left"><%=rst.getString("Body") %></td>
			<td  align="left"><%=rst.getString("UnProcessedStamps") %></td>
			<td  align="center"><%=rst.getString("MailFrom") %></td>
			</tr>
		<%
		i++;
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
	conn.close();
	conn1.close();
	}catch(Exception ee)
	{
		
	}
}
%>

</body>
</html>
