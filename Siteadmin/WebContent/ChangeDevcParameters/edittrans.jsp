<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL"
    import="java.net.URLEncoder" import="java.net.URLConnection" import="java.sql.Connection" import="java.sql.DriverManager"
    import="java.sql.ResultSet" import="java.sql.Statement" import="java.text.Format" import="java.text.SimpleDateFormat" 
    %>
<%@ include file="conn.jsp" %>
<%

String transporter=request.getParameter("transporter");

String transEmail=request.getParameter("transEmail");
transEmail=transEmail.replace("#","").replace("$","").replace("*","");
String rmemail=request.getParameter("transEmail1");
rmemail=rmemail.replace("#","").replace("$","").replace("*","");
String trainer=request.getParameter("transEmail2");
trainer=trainer.replace("#","").replace("$","").replace("*","");
String code=request.getParameter("transEmail11");
String uname=session.getAttribute("username").toString();
out.println("========"+transporter+"================="+transEmail+"============"+uname);

String dispMsg="",rid="",Category="",GeofenceMailid="";
Connection conn;
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try
{
	Statement stmt=conn.createStatement();
	Statement st=conn.createStatement();
	String sql1 ="";
	if(code.equalsIgnoreCase("-") || code=="-" || code.contains("-"))
	{
	 sql1="update db_gps.t_transportermailid set Email_Id='"+transEmail+"', rmemailid ='"+rmemail+"',trainer ='"+trainer+"', InsertedBy='"+uname+"' where TransporterName like '"+transporter+"'  "  ;
	out.println(sql1);
	stmt.executeUpdate(sql1);
	System.out.println(">>>>IF of code>>>");
	}else{
		 sql1="update db_gps.t_transportermailid set Email_Id='"+transEmail+"', rmemailid ='"+rmemail+"',trainer ='"+trainer+"', InsertedBy='"+uname+"' where TransporterName like '"+transporter+"' and TransporterCode ="+code+" "  ;
		out.println(sql1);
		stmt.executeUpdate(sql1);
		System.out.println(">>>>ELSE OF code>>>");
		
					
	}
	
	System.out.println(">>>>sql1"+sql1);
     	
	String sql3="select * from db_gps.t_transportermailid  where TransporterName like '"+transporter+"' " ;
	
	ResultSet rst3=st.executeQuery(sql3);
	System.out.println(">>>>sql"+sql3);
	if(rst3.next())
	{
		Category=rst3.getString("Category");
		GeofenceMailid=rst3.getString("GeofenceMailid");
		
		
	}
	
	
	String sql2="Insert into db_gps.t_transportermailidHistory (TransporterName, Email_Id,rmemailid,trainer,InsertedBy,Category,GeofenceMailid,TransporterCode) values('"+transporter+"','"+transEmail+"','"+rmemail+"','"+trainer+"','"+uname+"','"+Category+"','"+GeofenceMailid+"','"+code+"' ) "; 
	stmt.executeUpdate(sql2);
	System.out.println(">>>>sql"+sql2);
	dispMsg="Record Edited Successfully!";
}
catch(Exception e)
{
	out.println("Exception="+e);
	dispMsg="Unable to Edit Record!";
}
finally
{
    conn.close();
    response.sendRedirect("EditTransporter.jsp?dispMsg="+dispMsg);
}

	//	return "done";
	
%>