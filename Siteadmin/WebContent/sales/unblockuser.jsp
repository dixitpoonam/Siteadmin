<%@ include file="headerhtml.jsp" %>
<table border="0" align="center" width="100%">
<tr><td align="center"><i><b><font color="brown" size="2">Un-Block The User</font></i></b></td></tr>
<tr><td>
<%!
String sql;
Statement st,st1;Connection conn;
%>
<table border="0" width="100%">
<tr>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Sr.</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">User Name</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Message Id</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Messege</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Un-Block</font></td>
</tr>
<%

try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
	st=conn.createStatement();
	st1=conn.createStatement();
	sql="select * from t_usermessage";
	ResultSet rst=st.executeQuery(sql);
	int i=1;
	while(rst.next())
	{
	%>
	<tr>
	<td bgcolor="#f5f5f5"><%=i%></td>
	<td bgcolor="#f5f5f5" align="left"><b><%=rst.getString("UserTypeValue")%></b></td>
	<td bgcolor="#f5f5f5" align="center"><%=rst.getString("MessageId")%></td>
	<td bgcolor="#f5f5f5" align="left">
	<%
	sql="select * from t_message where Id='"+rst.getString("MessageId")+"'";	
	ResultSet rst1=st1.executeQuery(sql);
	if(rst1.next())
	{
	out.print(rst1.getString("Message"));
	}
	%>
	</td>
	<td bgcolor="#f5f5f5" align="center"><a href="javascript: flase" title="click to Unblock User" onclick="window.open('unblock.jsp?typevalue=<%=rst.getString("UserTypeValue")%>','win1','width=500,height=300,location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0')"><img src="../images/unblock.jpg" border="0"></a></td>
	</tr>
	<%
	i++;
	}

}catch(Exception e)
{
	out.print("Exception ---->"+e);
}finally
{
	conn.close();
	}
%>
</table>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>