<%@ include file="headerhtml.jsp" %>
<!-- <META HTTP-EQUIV=Refresh CONTENT='60; URL=onlineusers.jsp'>  -->
<table border="0" width="100%" align="center">
<tr>
    <td bgcolor="#f5f5f5" align="center"> <b> <font color="" size="2"> Repeated Re-provision No's </font> </b> &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <a href="excelrepeatreprov.jsp"> <img src="../images/excel.jpg" width="15px" height="15px" border="0"/> </a> </td>
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
try{
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
		<td bgcolor="#f5f5f5"> <a href="#" onClick="window.open ('repeatreprovdet.jsp?mobno=<%=rs1.getString("MobNo")%>', 'win1', 'width=450, height=550, location=0, menubar=0, scrollbars=1, status=0, toolbar=0 ,resizable=0')"> <%=rs1.getString("MobCount")%> </a> </td>
	</tr>		
<%
		i++;
	}
	}catch(Exception e)
	{
		out.print("Exception---->"+e);
	}finally{
		con1.close();
	}

%>
</table>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>
