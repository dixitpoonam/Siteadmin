<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="conn.jsp" %>
<html>
<body>

<%

Statement stmt1=null;
Statement stmt2=null;
Statement stmt3=null;
Class.forName(MM_dbConn_DRIVER);
Connection conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
stmt1 = conn1.createStatement();
stmt2 = conn1.createStatement();
stmt3 = conn1.createStatement();
String tid=request.getParameter("tid");
String techname=request.getParameter("techname");
String username=request.getParameter("techuname");
System.out.println("parameters are"+tid+""+techname+""+username);
String sql="update db_CustomerComplaints.t_techlist SET Available='No' where TID='"+tid+"' And TechName='"+techname+"'";
stmt1.executeUpdate(sql);
String sql2="select * from db_CustomerComplaints.t_admin where UName='"+username+"' AND Active='Yes'";

ResultSet rs=stmt2.executeQuery(sql2);
while(rs.next())
{
     if(username.equalsIgnoreCase(rs.getString("UNname")))
    	{
			String sql3="update db_CustomerComplaints.t_admin SET Active='No' where Uname='"+username+"' ";
			stmt3.executeUpdate(sql3);
		}

}
response.sendRedirect("deactivatetech.jsp");

%>






</body>
</html>