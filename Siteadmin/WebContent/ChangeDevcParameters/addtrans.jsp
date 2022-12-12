<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL"
    import="java.net.URLEncoder" import="java.net.URLConnection" import="java.sql.Connection" import="java.sql.DriverManager"
    import="java.sql.ResultSet" import="java.sql.Statement" import="java.text.Format" import="java.text.SimpleDateFormat" 
    %>
<%@ include file="conn.jsp" %>
<%

String transporter=request.getParameter("transporter");
String transEmail=request.getParameter("transEmail");
String uname=session.getAttribute("username").toString();
out.println("========"+transporter+"================="+transEmail+"============"+uname);
String dispMsg="";
Connection conn;
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try
{
	Statement stmt=conn.createStatement();
	//String sql1="update db_gps.t_transportermailid set Email_Id='"+transEmail+"', InsertedBy='"+uname+"' where TransporterName like '"+transporter+"'";
	String sql1="insert into db_gps.t_transportermailid (TransporterName,Email_Id,Category,InsertedBy) values ('"+transporter+"','"+transEmail+"','SendingLocation','"+uname+"')";
	out.println(sql1);
	stmt.executeUpdate(sql1);
	dispMsg="Record Added Successfully!";
}
catch(Exception e)
{
	out.println("Exception="+e);
	dispMsg="Unable to Add Record!";
}
finally
{
    conn.close();
    response.sendRedirect("AddTransporter.jsp?dispMsg="+dispMsg);
}

	//	return "done";
	
%>