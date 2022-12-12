<%@ include file="conn.jsp" %>
<%@page import="java.util.Date"%>
<%
Connection conn=null;
boolean Error=false;
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st1=null;
String fromDate="",toDate="";
try{
	st1=conn.createStatement();

	fromDate=new SimpleDateFormat("yyyy-MM-dd")
							.format(new SimpleDateFormat("dd-MMM-yyyy")
							.parse(request.getParameter("fromdate")));
	toDate=new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(request.getParameter("todate")));
	String unitids=request.getParameter("unitids");
	
	String sqlInsert="INSERT INTO db_gps.t_unitperformanceunits (fromdate,todate,unitids,enteredby,status) VALUES "+
					 "('"+fromDate+"','"+toDate+"','"+unitids+"','"+session.getAttribute("username").toString()+"','No') ";
	out.print(sqlInsert);
	st1.executeUpdate(sqlInsert);
	conn.close();
}catch(Exception e) 
{
	Error=true;
	out.print("Exceptions ...:"+e);

}
 response.sendRedirect("ListUnitPerformance.jsp?Error="+Error+"&fromdate="+request.getParameter("fromdate")+"&todate="+request.getParameter("todate"));
 
%>
