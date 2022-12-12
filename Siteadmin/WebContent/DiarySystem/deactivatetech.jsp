<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="headerhtml.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script language="javascript">

</script>
</head>
<body>


<% 

Class.forName(MM_dbConn_DRIVER);
Connection conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1 = conn1.createStatement();


%>
<% 
String sql="select TID,TechName,techuname,Available,Location,MobNo from db_CustomerComplaints.t_techlist where Available='yes'";
ResultSet rs=stmt1.executeQuery(sql);%>


<table border="0" width="100%" align="center">
<tr>


<td colspan="15" bgcolor="#f5f5f5" align="center">
<font color="black" size="2">
DEACTIVATION PAGE
</font>
</td>

<td align="right"><a href="#" onClick="window.open ('deactivatepage.jsp','win1','width=900,height=550,location=0,menubar=0,scrollbars=1,status=0,toolbar=0,resizable=0')">view Deactivated list</a></td>
</tr>
</table>







<table border="0" width="100%" align="center">
<tr>
<td align="center" bgcolor="#2696B8"><font color="white" size="2"><b>SrNo</b></font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2"><b>Techname</b></font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2"><b>Username</b></font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2"><b>Location</b></font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2"><b>Mobno</b></font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2"><b>Deactivate</b></font></td>
</tr>
<%
 int Srno=1;
while(rs.next())
{%>
	<tr>
	<td><%=Srno %></td>
	<td><%=rs.getString("TechName") %></td>
	<td><%=rs.getString("techuname") %></td>
	<td><%=rs.getString("Location") %></td>
	<td><%=rs.getString("MobNo") %></td>
	<td><a  href="deactivate.jsp?tid=<%=rs.getString("TID")%> &techname=<%=rs.getString("TechName")%>&techuname<%=rs.getString("techuname")%>">Deactivate</a></td>
	</tr>
	<%
	
Srno++;
 }%>








</table>

</body>
</html>