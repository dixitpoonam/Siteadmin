<%@ include file="headerhtml.jsp" %>
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="2"><u><i>
Edit Installation Limit
</i></u></font></td></tr>
<tr><td>
<%!
Statement st,st1;Connection conn;
String sql;
int insttotal,ordertotal,instcount,ordercount;
%>
<table border="0" width="100%" align="center">
<tr>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Sr.</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Transporter</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Current Installation</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Unit Ordered</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Edit</font></td>
</tr>
<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
	insttotal=0;
	ordertotal=0;
	st=conn.createStatement();
	st1=conn.createStatement();
	sql="select distinct(TypeValue) from t_security where TypeOfUser='Transporter' order by TypeValue";
	ResultSet rst=st.executeQuery(sql);
	int i=1;
	while(rst.next())
	{
	ordercount=0;
	instcount=0;
	%>
	<tr>
	<td bgcolor="#f5f5f5"><%=i%></td>
	<td bgcolor="#f5f5f5" align="left"><b><%=rst.getString("TypeValue")%></b></td>
	<td bgcolor="#f5f5f5" align="right">
	<%
		sql="select count(*) as count from t_vehicledetails where OwnerName='"+rst.getString("TypeValue")+"' and Status <> 'Deleted' ";
		ResultSet rst1=st1.executeQuery(sql);	
		if(rst1.next())
		{
		out.print(rst1.getInt("count"));
		instcount=rst1.getInt("count");
		insttotal=insttotal+rst1.getInt("count");
		}
	%>	
	</td>
	<td bgcolor="#f5f5f5" align="right">
	<%
		sql="select * from t_noofinstallations where Transporter='"+rst.getString("TypeValue")+"'";
		ResultSet rst2=st1.executeQuery(sql);
		if(rst2.next())
		{
			out.print(rst2.getInt("TotalInst"));
			ordercount=rst2.getInt("TotalInst");
			ordertotal=ordertotal+rst2.getInt("TotalInst");
		}
		else
		{
			out.print("-");
		}
	%>
	</td>
	<td bgcolor="#f5f5f5" align="center"><a href="javascript: flase" title="click to edit" onclick="window.open('editinstdetail.jsp?typevalue=<%=rst.getString("TypeValue")%>&instcount=<%=instcount%>&ordercount=<%=ordercount%>','win1','width=500,height=300,location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0')"><img src="../images/edit1.jpg" border="0"></a></td>
	</tr>
	<%
	i++;
	}
	%>
	<tr>
	<td colspan="2" bgcolor="#2696B8" align="right"><font color="white" size="2">Total :</font></td>
	<td bgcolor="#2696B8" align="right"><font color="white" size="2"><%=insttotal%></font></td>
	<td bgcolor="#2696B8" align="right"><font color="white" size="2"><%=ordertotal%></font></td>
	<td bgcolor="#2696B8" align="center">-</td>
	</tr>	
	<%
}catch(Exception e)
{
	out.print("Exception-->"+e);
}finally
{
	conn.close();
	}
%>
</table>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>