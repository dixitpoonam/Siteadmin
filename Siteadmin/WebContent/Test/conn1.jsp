<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" import="moreservlets.listeners.*" errorPage="" %>
<%!
String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
String MM_dbConn_USERNAME="site";
String MM_dbConn_PASSWORD="1@s2te";



String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
String MM_dbConn_STRING1="jdbc:mysql://localhost/db_avlalldata";
String MM_dbConn_STRING2="jdbc:mysql://localhost/test";


Connection conn,conn1,conn2;

%>
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn2 = DriverManager.getConnection(MM_dbConn_STRING2,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
}catch(Exception ee)
	{
		out.print("Connection Exception --->"+ee);
	}
%>
<h1>This is a connection test</h1>

6037
6038
6018 repair
