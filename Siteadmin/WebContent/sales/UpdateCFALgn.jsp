<%@ include file="headerhtml.jsp" %>
<%!
Connection conn;
%>
<% 
try {
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
Statement stmt1 = conn.createStatement();
ResultSet rs2=null;
String sql1="", sql2=""; 

String trans="", fn="", pass="", un="",typeofuser="";
int maxid=0;

String loc=request.getParameter("loc");
String id=request.getParameter("id");

String zonecode="",userid="";
String sql3="select ZoneCode from t_castrolzones where Zonedesc='"+loc+"'";
ResultSet rs3=stmt1.executeQuery(sql3);
if(rs3.next())
{
	zonecode=rs3.getString("ZoneCode");
}
		java.util.Date d = new java.util.Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String s=formatter.format(d);
sql1="Update t_subuser set Location ='"+loc+"',LocationCode ='"+zonecode+"' where UserId ='"+id+"'";
stmt1.executeUpdate(sql1);

response.sendRedirect("ChngCFALgn.jsp?inserted=successfull");
return;

} catch(Exception e) { out.println("Exception----->"+e); }
finally
{
	conn.close();
	}
%>
<%@ include file="footerhtml.jsp" %>