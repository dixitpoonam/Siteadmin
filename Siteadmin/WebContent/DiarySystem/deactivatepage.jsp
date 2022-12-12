<%@ page language="java" contentType="text/html; charset=ISO-8859-2"
    pageEncoding="ISO-8859-2"%>
<%@ include file="conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.02 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-2">
<title>Insert title here</title>
</head>
<body>

<% 

Class.forName(MM_dbConn_DRIVER);
Connection conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1 = conn1.createStatement();


%>






<table border="0" width="200%" align="center">
<tr>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">SrNo</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Techname</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Username</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Location</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Mobno</font></td>

</tr>
<% 
String sql="select TID,TechName,techuname,Available,Location,MobNo from db_CustomerComplaints.t_techlist where Available='No' order by TechName";
ResultSet rs=stmt1.executeQuery(sql);

int SrNo=1;
while(rs.next())
{%>
	<tr>
	
	<td><font size="2"><%=SrNo %></font></td>
	<td><font size="2"><%=rs.getString("TechName") %></font></td>
	<td><font size="2"><%=rs.getString("techuname") %></font></td>
	<td><font size="2"><%=rs.getString("Location") %></font></td>
	<td><font size="2"><%=rs.getString("MobNo") %></font></td>
	</tr>
	<%
SrNo++;	

 }%>








</table>
</body>
</html>