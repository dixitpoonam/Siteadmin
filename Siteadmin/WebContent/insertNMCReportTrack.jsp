<%@ include file="conn.jsp" %>
<%@page import="java.util.Date"%>

<%
	Connection conn=null;
boolean Error=false;
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st1=null;
Statement st2=null;
String fromDate="",toDate="";
String Msg="";
try{
	st1=conn.createStatement();
	st2=conn.createStatement();
	String reportName=request.getParameter("reportName");
	String reportNumber=request.getParameter("reportNumber");
	String pageName=request.getParameter("pageName");
	
	String sql="select PageName from db_gps.t_nmcreportnumber where PageName='"+pageName+"'";
	ResultSet rs1=st2.executeQuery(sql);
	if(rs1.next())
	{
	System.out.println("in if");
		Msg="1";
	}
	else
	{
	String sqlInsert="INSERT INTO db_gps.t_nmcreportnumber (ReportName,PageName,ActiveStatus,EnteredBy) VALUES "+
			 "('"+reportName+"','"+pageName+"','Yes',"+
			 "'"+session.getAttribute("username").toString()+"') ";
	st1.executeUpdate(sqlInsert);
	//ReportTracker reportGenerator=new ReportTracker();
	//reportGenerator.setReportNumber(st1);
	
	}
	conn.close();
}catch(Exception e) 
{
	Error=true;
	System.out.print("Exceptions ...:"+e);

}
if(Msg.equals("1"))
{
	 response.sendRedirect("NMCReportTrack.jsp?Msg="+Msg);
}
else
{
  response.sendRedirect("NMCReportTrackDetails.jsp?Error="+Error);
}
%>
