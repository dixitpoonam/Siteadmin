<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<%!
Connection conn;
%>
<% 

try {

	
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=conn.createStatement();
ResultSet rs1=null, rs4=null, rs5=null, rs7=null, rs8=null, rs10=null, rs11=null, rs13=null, rs14=null, rs15=null, rs16=null, rs17=null,rs18=null;
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="", sql7="", sql8="", sql9="", sql10="", sql11="", sql13="", sql14="", sql15="", sql16="", sql17="",sql18="";

String vehiclecode=request.getParameter("vehcode");
String vehno=request.getParameter("vehregno");
java.util.Date d=new java.util.Date();

String datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(d);
	String loginuser=session.getAttribute("username").toString();
	String tripid=request.getParameter("tripid");
	String comment=request.getParameter("comment");
	String othercomment=request.getParameter("othercomment");
	comment=comment+","+othercomment;
	String rfname=session.getAttribute("username").toString(); 
	
	
	
	sql2="INSERT INTO t_tripcomments (tripid, vehid, vehregno, comment, datetime, entby) values ('"+tripid+"', '"+vehiclecode+"', '"+vehno+"', '"+comment+"', '"+datetime+"','"+rfname+"') ";   
    System.out.print("Insertsql::>>>"+sql2);
	stmt1.executeUpdate(sql2);
	
	response.sendRedirect("tripcomment.jsp?inserted=yes&tripid="+tripid+"&vehcode="+vehiclecode+"&vehno="+vehno);
	return;

} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
	try{
conn.close();
	}
	catch(Exception ex)
	{}
} 
  
%>


	
