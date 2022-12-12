<%@ include file="headerhtml.jsp" %>
<table border="0" width="100%" align="center">
<tr><td align="center" bgcolor="#f5f5f5"><font color="black" size="3">Set Default Parameters for the Reports </font></td></tr>
<tr><td>
<table border="0" width="100%" align="center">
<tr>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Sr.</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Transporter</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">OS Limit</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">OS Dur.</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">RA</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">RD</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">ND From</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">ND To</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Stop Time</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">CD</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Device Dis.</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Action</font></td>
</tr>
<%
Statement st,st1;
String sql;
Connection conn;

%>
<%

Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try{
	st=conn.createStatement();
	st1=conn.createStatement();
	sql="select Distinct(TypeValue) from t_security where TypeOfUser in ('Transporter','Group') order by TypeValue";
	ResultSet rsttrans=st.executeQuery(sql);
	int i=1;
	while(rsttrans.next())
	{
	%>
	<tr>
	<td bgcolor="#f5f5f5"><%=i%></td>
	<td bgcolor="#f5f5f5"><%=rsttrans.getString("TypeValue")%></td>
	
	<%
		sql="select * from t_defaultvals where OwnerName='"+rsttrans.getString("TypeValue")+"'";
		ResultSet rst1=st1.executeQuery(sql);
		if(rst1.next())
		{	
	%>
	<td bgcolor="#f5f5f5" align="right"><%=rst1.getString("overspeedlimit")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst1.getString("overspeeddurationinsecs")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst1.getString("accelerationspeedvarlimit")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst1.getString("decelerationspeedvarlimit")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst1.getString("nightdrivingfromtime")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst1.getString("nightdrivingtotime")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst1.getString("stoppagesgreaterthaninmins")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst1.getString("continuousrunhrslimit")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst1.getString("disconnectedperiod")%></td>
	<td bgcolor="#f5f5f5" align="right"><a href="javascript: flase" title="click to edit values" onclick="window.open('editdefaultvals.jsp?tran=<%=rsttrans.getString("TypeValue")%>','win1','width=500,height=400,location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0')"><img src="../images/edit1.jpg" border="0"></a></td>
	<%
	}
	else
	{
		sql="select * from t_defaultvals where OwnerName='Default'";
		ResultSet rst2=st1.executeQuery(sql);
		if(rst2.next())
		{
		%>
	<td bgcolor="#f5f5f5" align="right"><%=rst2.getString("overspeedlimit")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst2.getString("overspeeddurationinsecs")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst2.getString("accelerationspeedvarlimit")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst2.getString("decelerationspeedvarlimit")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst2.getString("nightdrivingfromtime")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst2.getString("nightdrivingtotime")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst2.getString("stoppagesgreaterthaninmins")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst2.getString("continuousrunhrslimit")%></td>
	<td bgcolor="#f5f5f5" align="right"><%=rst2.getString("disconnectedperiod")%></td>
	<td bgcolor="#f5f5f5" align="right"><a href="javascript: flase" title="click to edit values" onclick="window.open('editdefaultvals.jsp?tran=<%=rsttrans.getString("TypeValue")%>','win1','width=500,height=400,location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0')"><img src="../images/edit1.jpg" border="0"></a></td>
	 <%
		}
	}	
	%>
	</tr>
	<%
	i++;
	}
}catch(Exception e)
{	
	out.print("Exception----->"+e);
}finally{
	conn.close();
}
%>
</table>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>