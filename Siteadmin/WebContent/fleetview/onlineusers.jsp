<%@ include file="headerhtml.jsp" %>
<table border="0" width="100%" align="center">
<tr><td bgcolor="#f5f5f5" align="center"><b><font color="" size="2">List of Users Who are Currently Online</font></b></td></tr>
<tr><td align="center">
<table border="0" width="100%" align="center">
<tr>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Sr.</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Login Id </font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Owner Name</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Contact No</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Location</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Last Activity Time</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">User Ip</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Release Session</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Logout</font></td>
<tr>	
<%!
Statement st,st1;
String sql,thedate,trans,conno,conname;
Connection conn;

%>
<%

	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	try{
	st=conn.createStatement();
	st1=conn.createStatement();
	java.util.Date dt= new java.util.Date();
	long mils=dt.getTime();
	long mins=20*60*1000;
	mils=mils-mins;
	dt.setTime(mils);
	thedate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dt);
	sql="select * from t_sessions where Updated >='"+thedate+"' and ActiveStatus='Yes' order by Updated desc";
	ResultSet rst=st.executeQuery(sql);
	int i=1;
	while(rst.next())
	{
		sql="select * from t_security where UserName='"+rst.getString("UserName")+"'";
		ResultSet rst1=st1.executeQuery(sql);
		if(rst1.next())
		{
			trans=rst1.getString("TypeValue");
		}
		sql="select * from t_userdetails where UserName='"+rst.getString("UserName")+"' order by MobNo desc";
		ResultSet rstcontact=st1.executeQuery(sql);
		conno="";
		conname="";
		if(rstcontact.next())
		{
			conno=rstcontact.getString("MobNo");
			conname=rstcontact.getString("Location");
		}
		%>
		<tr>
		<td bgcolor="#f5f5f5"><%=i%></td>
		<td bgcolor="#f5f5f5"><%=rst.getString("UserName")%></td>
		<td bgcolor="#f5f5f5"><%=trans%></td>
		<td bgcolor="#f5f5f5"><%=conno%></td>
		<td bgcolor="#f5f5f5"><%=conname%></td>
		<td bgcolor="#f5f5f5"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("Updated")))%></td>
		<td bgcolor="#f5f5f5"><%=rst.getString("UserIp")%></td>
		<td bgcolor="#f5f5f5" align="center"><a href="javascript: flase" title="click to Unblock User" onclick="window.open('release.jsp?typevalue=<%=rst.getString("UserName")%>','win1','width=500,height=300,location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0')"><img src="../images/unblock.jpg" border="0"></a></td>
		<td bgcolor="#f5f5f5" align="center"><a href="javascript: flase" title="click to Unblock User" onclick="window.open('logoutuser.jsp?typevalue=<%=rst.getString("UserName")%>','win1','width=500,height=300,location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0')"><img src="../images/unblock.jpg" border="0"></a></td>
		</tr>		
		<%
		i++;
	}
	}catch(Exception e)
	{
		out.print("Exception---->"+e);
	}finally{
		conn.close();
	}

%>
</table>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>
