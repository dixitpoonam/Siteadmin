<%@ page contentType="application/vnd.ms-excel; charset=gb2312" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<% response.setContentType("application/vnd.ms-excel");

String filename="repeatreprov.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>

<%@ include file="conn.jsp" %>


<table border="0" width="100%" align="center">
<tr>
    <td bgcolor="#f5f5f5" align="center"> <b> <font color="" size="2"> Repeated Re-provision No's </font> </b> </td>
</tr>
<tr>
    <td align="center">
	<table border="0" width="60%" align="center">
	    <tr>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Sr No </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Mob No </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Count </font> </td>
</tr>	

<%!
Statement stmt1;Connection con1;
%>

<%

try
{
	
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	stmt1=con1.createStatement();
	ResultSet rs1=null;
	String sql1="";

	int i=1;
	sql1="select * from t_mobilecount order by MobCount desc";
	rs1=stmt1.executeQuery(sql1);
	while(rs1.next())
	{ %>
	<tr>
		<td bgcolor="#f5f5f5"> <%=i%> </td>
		<td bgcolor="#f5f5f5"> <%=rs1.getString("MobNo")%></td>
		<td bgcolor="#f5f5f5"> <%=rs1.getString("MobCount")%>  </td>
	</tr>		
<%
		i++;
	}
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
