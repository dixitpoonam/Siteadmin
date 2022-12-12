<%@ include file="conn.jsp" %>
<%@page import="java.util.Date"%>
<%@ page import="com.ReportTrack1.ReportTracker" %>
<%
	Connection conn=null;
boolean Error=false;
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st1=null;
String fromDate="",toDate="";
try{
	st1=conn.createStatement();
	 
	String reportName=request.getParameter("reportName");
	String reportNumber=request.getParameter("reportNumber");
	String pageName=request.getParameter("pageName");
	
	String sqlInsert="INSERT INTO db_gps.t_reportnumber (ReportName,PageName,ReportNumber,ActiveStatus,EnteredBy) VALUES "+
			 "('"+reportName+"','"+pageName+"','"+reportNumber+"','Yes',"+
			 "'"+session.getAttribute("username").toString()+"') ";
	st1.executeUpdate(sqlInsert);
	ReportTracker reportGenerator=new ReportTracker();
	reportGenerator.setReportNumber(st1);
	
	
	conn.close();
}catch(Exception e) 
{
	Error=true;
	out.print("Exceptions ...:"+e);

}
 response.sendRedirect("ReportTrackDetails.jsp?Error="+Error);
%>
