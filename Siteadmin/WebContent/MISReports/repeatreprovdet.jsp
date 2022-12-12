<%@ include file="conn.jsp" %>
<!-- <META HTTP-EQUIV=Refresh CONTENT='60; URL=onlineusers.jsp'>  -->
<%!Connection con1; %>
<%
	String mobno=request.getParameter("mobno");	

%>
<table border="0" width="100%" align="center">
<tr>
    <td bgcolor="#f5f5f5" align="center"> <b> <font color="" size="2"> Re-provision Dates of <%=mobno%> </font> </b> &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <a href="excelrepeatreprovdet.jsp?mobno=<%=mobno%>"> <img src="../images/excel.jpg" width="15px" height="15px" border="0"/> </a> </td>
</tr>
<tr>
    <td align="center">
	<table border="0" width="60%" align="center">
	    <tr>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Sr No </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Date </font> </td>
		
</tr>	

<%!
Statement stmt1;
%>

<%
try{
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	stmt1=con1.createStatement();
	ResultSet rs1=null,rs2=null;
	String sql1="", sql2="";

	int i=1;
	sql1="select * from t_reprovisiondailynum where MobileNo='"+mobno+"' order by ondate desc";	
	rs1=stmt1.executeQuery(sql1);
	while(rs1.next())
	{ %>
	<tr>
		<td bgcolor="#f5f5f5"> <%=i%> </td>
		<td bgcolor="#f5f5f5"> <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("ondate")))%> </td>
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
